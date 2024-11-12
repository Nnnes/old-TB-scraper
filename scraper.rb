TIME = Time.now
t = TIME

$stdout.sync = true

require 'net/http'
require 'nokogiri'
require 'sqlite3'
require 'date'

def max_page(html)
  html.css('.leaderboard .palace-floor center a.btn').map{ |x| x['href'][/\d+$/].to_i }.max
end

Entry = Struct.new(:rank, :id, :user, :twitch, :char, :loop, :stage, :score,
  :ultra, :muts, :weapons, :crown, :killedby)

def parse_scoreboard(html)
  table = html.at_css('.profile-scores')
  return nil if table == nil
  entries = table.css('.scoreboard-entry')
  details = table.css('.scoreboard-details-row')

  data = []

  entries.zip(details).map do |e|
    Entry.new(
      e[0].at_css('.scoreboard-rank .scoreboard-value').text.to_i,
      e[0].at_css('.scoreboard-user a')['href'][8..-1].to_i,
      e[0].at_css('.scoreboard-user a').text.strip,
      e[0].at_css('.scoreboard-twitch a').then{ |x| x ? x['href'][18..-1] : nil },
      e[0].at_css('.character')['class'][/(?<=character-).+$/],
      e[0].at_css('.daily-level').children[0].text[/\d+/].to_i,
      e[0].at_css('.daily-level').children[2].text,
      e[0].at_css('.scoreboard-score').text.to_i,
      e[1].at_css('.ultra').then{ |x| x ? x['class'][/(?<=ultra-).+$/].to_i : nil },
      e[1].css('.mutation').map{ |x| x['class'][/(?<=mutation-).+$/].to_i }.reduce(0){ |a, x| a |= (1 << x) },
      e[1].css('.weapon').map{ |x| x['class'][/(?<=weapon-).+$/].to_i }.then{ |x| x[0] * 1000 + x[1] },
      e[1].at_css('.crown').then{ |x| x ? x['class'][/(?<=crown-).+$/].to_i : nil },
      e[1].at_css('.deathflag').then{ |x| x ? x['src'][16..-5].to_i : nil },
    )
  end
end

# test URLs
# https://thronebutt.com/archive/21022016 - First daily
# https://thronebutt.com/archive/21022016/6 - Run ended in a victory.
# https://thronebutt.com/archive/22062022/15 - Whoops, looks like something went wrong.
# https://thronebutt.com/archive/21022018/61 - There are no more scores!

ERROR_RETRY_ATTEMPTS = 10

db = SQLite3::Database.new('tb.db')

end_date = db.execute('SELECT value FROM metadata WHERE key="end_date"').dig(0, 0)
unless end_date
  end_date = db.execute('SELECT MAX(jdate) FROM runs').dig(0, 0) || Date.new(2016, 02, 20).jd
  db.execute('INSERT INTO metadata VALUES (?,?)', ['end_date', end_date.to_i])
end
end_date = end_date.to_i

Signal.trap("SIGINT") do
  db.rollback if db.transaction_active?
  puts "\n#{downloaded_days} days downloaded in #{(t - TIME).round} seconds"
  exit
end

no_pause = ARGV.any? /^-?-no-pause$/

days_to_download = (ARGV.find{_1.to_i != 0} || -1).to_i
downloaded_days = 0
date_limit = Time.now.getutc.to_date.jd - 2

if end_date + days_to_download > date_limit || days_to_download == -1
  days_to_download = date_limit - end_date
end

if days_to_download <= 0
  puts "Database is up to date!"
else
  puts "Downloading #{Date.jd(end_date)} through #{Date.jd(end_date + days_to_download)}"
end

days_to_download.times do |i|
  puts "#{i + 1} of #{days_to_download} days"
  db.transaction
  end_date += 1
  base_url = 'https://thronebutt.com/archive/' + Date.jd(end_date).strftime('%d%m%Y')
  pages = nil
  page = 1
  attempts = 0
  continue = true
  while pages == nil || page <= pages
    url = base_url
    url += "/#{page}" if page > 1
    begin
      print url
      resp = Net::HTTP.get_response(URI(url))
      print ' '
    rescue => ex
      puts ex.full_message
      attempts += 1
      if ERROR_RETRY_ATTEMPTS >= 0 && attempts > ERROR_RETRY_ATTEMPTS
        print "\nToo many attempts!"
        Process.kill('INT', 0)
      end
      puts "reattempting in #{2**attempts} seconds"
      (2**attempts).times { print ?.; sleep 1 }
      puts
      redo
    end
    attempts = 0
    case resp
    when Net::HTTPSuccess
      html = Nokogiri::HTML5(resp.body)
      pages ||= max_page(html)
      data = parse_scoreboard(html)
      if data == nil
        puts 'empty'
        break
      end
      data.each do |run|
        db.execute('INSERT INTO runs VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
          [end_date, run.rank, run.id, run.char, run.loop, run.stage, run.score,
            run.ultra, run.muts, run.weapons, run.crown, run.killedby])
        db.execute('INSERT INTO players VALUES (?,?) ON CONFLICT(id) DO UPDATE SET username=excluded.username',
          [run.id, run.user])
      end
      puts 'read' + (page == 1 || page % 10 == 0 ? " (<=#{pages} pages)" : '')
    when Net::HTTPTooManyRequests
      retry_after = resp['retry-after'].to_i
      puts "rate limited; trying again in #{retry_after} seconds"
      retry_after.times do |sec|
        print(retry_after - sec < 10 ? retry_after - sec : ?.)
        sleep 1
      end
      puts
      redo
    when Net::HTTPNotFound
      db.execute('INSERT INTO errors VALUES (?,?)', [end_date, 0])
      puts "failed (#{resp.code} #{resp.message})"
      break
    else
      db.execute('INSERT INTO errors VALUES (?,?)', [end_date, page])
      puts "failed (#{resp.code} #{resp.message})"
    end
    page += 1
  end
  db.execute('UPDATE metadata SET value=? WHERE key="end_date"', end_date)
  db.commit
  downloaded_days += 1
  t = Time.now
  puts "#{Date.jd(end_date)} committed to db"
end

puts "#{downloaded_days} day#{downloaded_days == 1 ? '' : 's'} downloaded in #{(t - TIME).round} seconds"
unless no_pause
  print 'OK to close'
  gets
  puts
end
