require 'sqlite3'
require 'date'

module NT
  private_class_method def self.reverse_constant_lookup(mod, const)
    mod.constants.find{ |c| mod.const_get(c) == const }
  end

  module Character
    RANDOM = 0
    FISH = 1
    CRYSTAL = 2
    EYES = 3
    MELTING = 4
    PLANT = 5
    YV = 6
    STEROIDS = 7
    ROBOT = 8
    CHICKEN = 9
    REBEL = 10
    HORROR = 11
    ROGUE = 12
    BIG_DOG = 13
    SKELETON = 14
    FROG = 15
    CUZ = 16
  end
  def self.Character(x)
    reverse_constant_lookup(self::Character, x)
  end

  module Ultra
    BLOOD_BOND = 1
    GUN_BOND = 2
    EXTRA_LEVEL = 3
    CONFISCATE = 11
    GUN_WARRANT = 12
    FORTRESS = 21
    JUGGERNAUT = 22
    PROJECTILE_STYLE = 31
    MONSTER_STYLE = 32
    BRAIN_CAPACITY = 41
    DETACHMENT = 42
    TRAPPER = 51
    KILLER = 52
    IMA_GUN_GOD = 61
    BACK_2_BIZNIZ = 62
    AMBIDEXTROUS = 71
    GET_LOADED = 72
    REFINED_TASTE = 81
    REGURGITATE = 82
    HARDER_TO_KILL = 91
    DETERMINATION = 92
    PERSONAL_GUARD = 101
    RIOT = 102
    STALKER = 111
    ANOMALY = 112
    MELTDOWN = 113
    SUPER_PORTAL_STRIKE = 121
    SUPER_BLAST_ARMOR = 122
    ULTRA_SPIN = 131
    ULTRA_MISSILES = 132
    REDEMPTION = 141
    DAMNATION = 142
    DISTANCE = 151
    INTIMACY = 152
    GAME_GOD = 161
    CAR_GOD = 162
  end
  def self.Ultra(x)
    reverse_constant_lookup(self::Ultra, x)
  end

  module Mut
    HEAVY_HEART = 0
    RHINO_SKIN = 1
    EXTRA_FEET = 2
    PLUTONIUM_HUNGER = 3
    RABBIT_PAW = 4
    THRONE_BUTT = 5
    LUCKY_SHOT = 6
    BLOODLUST = 7
    GAMMA_GUTS = 8
    SECOND_STOMACH = 9
    BACK_MUSCLE = 10
    SCARIER_FACE = 11
    EUPHORIA = 12
    LONG_ARMS = 13
    BOILING_VEINS = 14
    SHOTGUN_SHOULDERS = 15
    RECYCLE_GLAND = 16
    LASER_BRAIN = 17
    LAST_WISH = 18
    EAGLE_EYES = 19
    IMPACT_WRISTS = 20
    BOLT_MARROW = 21
    STRESS = 22
    TRIGGER_FINGERS = 23
    SHARP_TEETH = 24
    PATIENCE = 25
    HAMMERHEAD = 26
    STRONG_SPIRIT = 27
    OPEN_MIND = 28

    def self.pack(muts)
      muts.reduce(0){ |a, x| a |= (1<<x) }
    end
    def self.unpack(muts)
      muts.to_s(2).reverse.split('').each_with_index.select{ |x| x[0] == '1' }.map(&:last)
    end
  end
  def self.Mut(x)
    x = 0 if x == 29 # Heavy Heart
    reverse_constant_lookup(self::Mut, x)
  end

  module Weapon
    REVOLVER = 1
    TRIPLE_MACHINEGUN = 2
    WRENCH = 3
    MACHINEGUN = 4
    SHOTGUN = 5
    CROSSBOW = 6
    GRENADE_LAUNCHER = 7
    DOUBLE_SHOTGUN = 8
    MINIGUN = 9
    AUTO_SHOTGUN = 10
    AUTO_CROSSBOW = 11
    SUPER_CROSSBOW = 12
    SHOVEL = 13
    BAZOOKA = 14
    STICKY_LAUNCHER = 15
    SMG = 16
    ASSAULT_RIFLE = 17
    DISC_GUN = 18
    LASER_PISTOL = 19
    LASER_RIFLE = 20
    SLUGGER = 21
    GATLING_SLUGGER = 22
    ASSAULT_SLUGGER = 23
    ENERGY_SWORD = 24
    SUPER_SLUGGER = 25
    HYPER_RIFLE = 26
    SCREWDRIVER = 27
    LASER_MINIGUN = 28
    BLOOD_LAUNCHER = 29
    SPLINTER_GUN = 30
    TOXIC_BOW = 31
    SENTRY_GUN = 32
    WAVE_GUN = 33
    PLASMA_GUN = 34
    PLASMA_CANNON = 35
    ENERGY_HAMMER = 36
    JACKHAMMER = 37
    FLAK_CANNON = 38
    GOLDEN_REVOLVER = 39
    GOLDEN_WRENCH = 40
    GOLDEN_MACHINEGUN = 41
    GOLDEN_SHOTGUN = 42
    GOLDEN_CROSSBOW = 43
    GOLDEN_GRENADE_LAUNCHER = 44
    GOLDEN_LASER_PISTOL = 45
    CHICKEN_SWORD = 46
    NUKE_LAUNCHER = 47
    ION_CANNON = 48
    QUADRUPLE_MACHINEGUN = 49
    FLAMETHROWER = 50
    DRAGON = 51
    FLARE_GUN = 52
    ENERGY_SCREWDRIVER = 53
    HYPER_LAUNCHER = 54
    LASER_CANNON = 55
    RUSTY_REVOLVER = 56
    LIGHTNING_PISTOL = 57
    LIGHTNING_RIFLE = 58
    LIGHTNING_SHOTGUN = 59
    SUPER_FLAK_CANNON = 60
    SAWED_OFF_SHOTGUN = 61
    SPLINTER_PISTOL = 62
    SUPER_SPLINTER_GUN = 63
    LIGHTNING_SMG = 64
    SMART_GUN = 65
    HEAVY_CROSSBOW = 66
    BLOOD_HAMMER = 67
    LIGHTNING_CANNON = 68
    POP_GUN = 69
    PLASMA_RIFLE = 70
    POP_RIFLE = 71
    TOXIC_LAUNCHER = 72
    FLAME_CANNON = 73
    LIGHTNING_HAMMER = 74
    FLAME_SHOTGUN = 75
    DOUBLE_FLAME_SHOTGUN = 76
    AUTO_FLAME_SHOTGUN = 77
    CLUSTER_LAUNCHER = 78
    GRENADE_SHOTGUN = 79
    GRENADE_RIFLE = 80
    ROGUE_RIFLE = 81
    PARTY_GUN = 82
    DOUBLE_MINIGUN = 83
    GATLING_BAZOOKA = 84
    AUTO_GRENADE_SHOTGUN = 85
    ULTRA_REVOLVER = 86
    ULTRA_LASER_PISTOL = 87
    SLEDGEHAMMER = 88
    HEAVY_REVOLVER = 89
    HEAVY_MACHINEGUN = 90
    HEAVY_SLUGGER = 91
    ULTRA_SHOVEL = 92
    ULTRA_SHOTGUN = 93
    ULTRA_CROSSBOW = 94
    ULTRA_GRENADE_LAUNCHER = 95
    PLASMA_MINIGUN = 96
    DEVASTATOR = 97
    GOLDEN_PLASMA_GUN = 98
    GOLDEN_SLUGGER = 99
    GOLDEN_SPLINTER_GUN = 100
    GOLDEN_SCREWDRIVER = 101
    GOLDEN_BAZOOKA = 102
    GOLDEN_ASSAULT_RIFLE = 103
    SUPER_DISC_GUN = 104
    HEAVY_AUTO_CROSSBOW = 105
    HEAVY_ASSAULT_RIFLE = 106
    BLOOD_CANNON = 107
    DOG_SPIN_ATTACK = 108
    DOG_MISSILE = 109
    INCINERATOR = 110
    SUPER_PLASMA_CANNON = 111
    SEEKER_PISTOL = 112
    SEEKER_SHOTGUN = 113
    ERASER = 114
    GUITAR = 115
    BOUNCER_SMG = 116
    BOUNCER_SHOTGUN = 117
    HYPER_SLUGGER = 118
    SUPER_BAZOOKA = 119
    FROG_PISTOL = 120
    BLACK_SWORD = 121
    GOLDEN_NUKE_LAUNCHER = 122
    GOLDEN_DISC_GUN = 123
    HEAVY_GRENADE_LAUNCHER = 124
    GUN_GUN = 125
    EGGPLANT = 126
    GOLDEN_FROG_PISTOL = 127

    def self.pack(weapons)
      weapons[0] * 1000 + weapons[1]
    end
    def self.unpack(weapons)
      [weapons / 1000, weapons % 1000]
    end
  end
  def self.Weapon(x)
    return nil if x == 0
    reverse_constant_lookup(self::Weapon, x)
  end

  module Crown
    RANDOM = 0
    NONE = 1
    DEATH = 2
    LIFE = 3
    HASTE = 4
    GUNS = 5
    HATRED = 6
    BLOOD = 7
    DESTINY = 8
    LOVE = 9
    LUCK = 10
    CURSES = 11
    RISK = 12
    PROTECTION = 13
  end
  def self.Crown(x)
    reverse_constant_lookup(self::Crown, x)
  end

  module DeathCause
    BANDIT = 0
    MAGGOT = 1
    RAD_MAGGOT = 2
    BIG_MAGGOT = 3
    SCORPION = 4
    GOLDEN_SCORPION = 5
    BIG_BANDIT = 6
    RAT = 7
    BIG_RAT = 8
    GREEN_RAT = 9
    GATOR = 10
    FROG = 11
    SUPER_FROG = 12
    MOM = 13
    ASSASSIN = 14
    RAVEN = 15
    SALAMANDER = 16
    SNIPER = 17
    BIG_DOG = 18
    SPIDER = 19
    NEW_CAVE_THING = 20
    LASER_CRYSTAL = 21
    HYPER_CRYSTAL = 22
    SNOW_BANDIT = 23
    SNOWBOT = 24
    WOLF = 25
    SNOWTANK = 26
    LIL_HUNTER = 27
    FREAK = 28
    EXPLO_FREAK = 29
    RHINO_FREAK = 30
    NECROMANCER = 31
    TURRET = 32
    TECHNOMANCER = 33
    GUARDIAN = 34
    EXPLO_GUARDIAN = 35
    DOG_GUARDIAN = 36
    THRONE = 37
    THRONE_II = 38
    BONEFISH = 39
    CRAB = 40
    TURTLE = 41
    MOLEFISH = 42
    MOLESARGE = 43
    FIREBALLER = 44
    SUPER_FIREBALLER = 45
    JOCK = 46
    CURSED_SPIDER = 47
    CURSED_CRYSTAL = 48
    MIMIC = 49
    HEALTH_MIMIC = 50
    GRUNT = 51
    INSPECTOR = 52
    SHIELDER = 53
    CROWN_GUARDIAN = 54
    EXPLOSION = 55
    SMALL_EXPLOSION = 56
    FIRE_TRAP = 57
    SHIELD = 58
    TOXIC = 59
    HORROR = 60
    BARREL = 61
    TOXIC_BARREL = 62
    GOLDEN_BARREL = 63
    CAR = 64
    VENUS_CAR = 65
    VENUS_CAR_FIXED = 66
    VENUS_CAR_2 = 67
    ICY_CAR = 68
    THROWN_CAR = 69
    MINE = 70
    CROWN_OF_DEATH = 71
    ROGUE_STRIKE = 72
    BLOOD_LAUNCHER = 73
    BLOOD_CANNON = 74
    BLOOD_HAMMER = 75
    DISC = 76
    CURSE = 77
    BIG_DOG_MISSILE = 78
    HALLOWEEN_BANDIT = 79
    LIL_HUNTER_FLY = 80
    THRONE_DEATH = 81
    JUNGLE_BANDIT = 82
    JUNGLE_ASSASSIN = 83
    JUNGLE_FLY = 84
    CROWN_OF_HATRED = 85
    ICE_FLOWER = 86
    CURSED_AMMO_PICKUP = 87
    ELECTROCUTION = 88
    ELITE_GRUNT = 89
    BLOOD_GAMBLE = 90
    ELITE_SHIELDER = 91
    ELITE_INSPECTOR = 92
    CAPTAIN = 93
    VAN = 94
    BUFF_GATOR = 95
    GENERATOR = 96
    LIGHTNING_CRYSTAL = 97
    GOLDEN_SNOWTANK = 98
    GREEN_EXPLOSION = 99
    SMALL_GENERATOR = 100
    GOLDEN_DISC = 101
    BIG_DOG_EXPLOSION = 102
    POPO_FREAK = 103
    THRONE_II_DEATH = 104
    BIG_FISH = 105
  end
  def self.DeathCause(x)
    reverse_constant_lookup(self::DeathCause, x)
  end
end

module NT
  module Player
    CORN_CRAB = 8
    CUBIC_BLUE = 28583
    PANGKLES = 61275
    ALYSSA = 74567
    FIREBAT = 94279
    MASTER_SPARKY = 127826
    DELTA = 135750
    NNNES = 136555
    WONDERIS = 154439
    MELT_MAN = 219099
    GNUKE = 342010
    CONDIMENT_KING = 373523
    KALLOR = 382992
    RYGUY = 384051
    KOBA = 432937
  end
end

db = SQLite3::Database.new('tb.db', {readonly: true})

class String
  def title_case
    self.downcase.gsub(/\b(\w)/){ |m| m.upcase }
  end
end

class Symbol
  def title_case
    self.to_s.tr(?_, ' ').title_case.sub(/\bIi\b/, 'II')
  end
end

class Object
  def title_case
    self.to_s.title_case
  end
end

def parse(row, db) = {
  Date: Date.jd(row[0].to_i).to_s,
  Rank: row[1], Page: (row[1] - 1) / 30 + 1,
  Player: db.execute('SELECT username FROM players WHERE id=?', row[2]).first.first,
  Character: row[3] ? row[3][/^[^B]+/] : row[3],
  Skin: row[3] ? (row[3].end_with?(?B) ? 'B' : 'A') : row[3],
  Stage: "L#{row[4]} #{row[5]}",
  Score: row[6],
  Ultra: NT::Ultra(row[7]),
  Mutations: NT::Mut.unpack(row[8]).map{ |x| NT::Mut(x) },
  Weapons: NT::Weapon.unpack(row[9]).map{ |x| NT::Weapon(x) },
  Crown: NT::Crown(row[10]),
  Killer: NT::DeathCause(row[11])
}

def mut_performance(id, db, missing = false)
  out = NT::Mut.constants.map do |c|
    [c.to_s.tr(?_, ' ').title_case,
      db.execute('SELECT COUNT(*), AVG(score) FROM runs WHERE id == ? AND (muts >> ?) % 2 == ?' +
      (missing ? ' AND ultra IS NOT NULL' : ''), id, NT::Mut.const_get(c), (missing ? 0 : 1))
      .flatten.then{ |x| [x[0], x[1].nil? ? 0 : x[1].round(2)] }
    ].flatten
  end
  out.sort_by{ |x| missing ? [x[2], x[1], x] : [-x[2], -x[1], x] }
end

def mut_performance_diff(id, db, level_ultra_only = true)
  ultra = level_ultra_only ? ' ultra IS NOT NULL AND ' : ''
  out = NT::Mut.constants.map do |c|
    if id
      [c.to_s.tr(?_, ' ').title_case,
        db.execute('SELECT COUNT(*), AVG(score) FROM runs WHERE' + ultra + 'id == ? AND (muts >> ?) % 2 == 0', id,
        NT::Mut.const_get(c)).flatten.then{ |x| [x[0], x[1].nil? ? 0 : x[1].round(2)]},
        db.execute('SELECT COUNT(*), AVG(score) FROM runs WHERE' + ultra + 'id == ? AND (muts >> ?) % 2 == 1', id,
        NT::Mut.const_get(c)).flatten.then{ |x| [x[0], x[1].nil? ? 0 : x[1].round(2)]}].flatten
    else
      [c.to_s.tr(?_, ' ').title_case,
        db.execute('SELECT COUNT(*), AVG(score) FROM runs WHERE' + ultra + '(muts >> ?) % 2 == 0',
        NT::Mut.const_get(c)).flatten.then{ |x| [x[0], x[1].nil? ? 0 : x[1].round(2)]},
        db.execute('SELECT COUNT(*), AVG(score) FROM runs WHERE' + ultra + '(muts >> ?) % 2 == 1',
        NT::Mut.const_get(c)).flatten.then{ |x| [x[0], x[1].nil? ? 0 : x[1].round(2)]}].flatten
    end
  end
  out.map{ |x| [x[0], x[3], x[2], x[4], "#{x[4] > x[2] ? ?+ : ''}#{(x[4] - x[2]).round(2)}"] }.sort_by{ |x| -x[4].to_f }
end

def print_sets
  sets = {
    p9: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::BLOODLUST,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::LASER_BRAIN, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT],
    p9p: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::BLOODLUST,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::LASER_BRAIN, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT, NT::Mut::PATIENCE],
    p8: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::BLOODLUST,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT],
    p8p: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::BLOODLUST,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT, NT::Mut::PATIENCE],
    paw9: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::RABBIT_PAW,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::LASER_BRAIN, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT],
    paw9p: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::RABBIT_PAW,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::LASER_BRAIN, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT, NT::Mut::PATIENCE],
    paw8: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::RABBIT_PAW,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT],
    paw8p: [NT::Mut::RHINO_SKIN, NT::Mut::PLUTONIUM_HUNGER, NT::Mut::RABBIT_PAW,
      NT::Mut::SCARIER_FACE, NT::Mut::LONG_ARMS, NT::Mut::STRESS,
      NT::Mut::TRIGGER_FINGERS, NT::Mut::STRONG_SPIRIT, NT::Mut::PATIENCE]
  }

  sets.each { |k, v| p [k, NT::Mut.pack(v)] }
end

def print_killedby(id, db)
  out = db.execute('SELECT killedby, COUNT(*) FROM runs WHERE id == ? GROUP BY killedby ORDER BY COUNT(*) DESC', id)
  out.map do |killedby, count|
    [NT::DeathCause(killedby).to_s.tr(?_, ' ').title_case.sub('Ii', 'II'), count]
  end
end

def print_user_runs_tsv(id, db)
  rows = db.execute('SELECT * FROM runs WHERE id == ?', id)

  rows.each do |row|
    row = parse(row, db)
    puts [row[:Date], row[:Rank], row[:Character].title_case, row[:Skin], row[:Stage], row[:Score], row[:Crown].title_case, row[:Killer].title_case, row[:Weapons].then{ |x| x + Array.new(2 - x.size){''} }.map{|x|x.title_case}, row[:Mutations].map(&:title_case)].flatten.join ?\t
  end
end

def table(ary, headers = nil, col_sep = ' | ')
  ary.unshift(headers.dup) if headers
  columns = ary.transpose.map{ |col| col.map{ |x| x.to_s.size }.max }
  ary.map do |row|
    out = row.zip(columns).map do |cell, width|
      cell = cell.to_s
      if headers
        cell = ' ' * ((width - cell.size) / 2) + cell + ' ' * ((width - cell.size + 1) / 2)
      else
        cell.ljust(width)
      end
    end.join(col_sep).rstrip
    headers = nil
    out
  end
end

def deaths(id, db)
  if id
    rows = db.execute('SELECT killedby, COUNT(*) FROM runs WHERE id == ? GROUP BY killedby', id)
  else
    rows = db.execute('SELECT killedby, COUNT(*) FROM runs GROUP BY killedby')
  end
  h = rows.to_h
  h.default = 0
  rows = NT::DeathCause.constants.map do |c|
    [c.title_case, h[NT::DeathCause.const_get(c)]]
  end
  rows.sort_by{ |x| [-x[1], x[0]] }
end

def mut_count_by_day(db)
  rows = db.execute('SELECT jdate, muts FROM runs')
  h = {}
  h.default = 0
  rows.each do |jdate, muts|
    h[jdate] |= muts
  end
  NT::Mut.constants.map do |c|
    [c.title_case, h.size - h.values.count{ |x| NT::Mut.unpack(x).include?(NT::Mut.const_get(c)) }]
  end
end

# set = [
#   NT::Mut::STRONG_SPIRIT,
#   NT::Mut::TRIGGER_FINGERS,
#   NT::Mut::LONG_ARMS,
#   NT::Mut::RHINO_SKIN,
#   NT::Mut::SCARIER_FACE,
#   NT::Mut::LASER_BRAIN,
#   NT::Mut::STRESS,
#   NT::Mut::PLUTONIUM_HUNGER,
#   NT::Mut::BLOODLUST
# ]
# set2 = set + [NT::Mut::PATIENCE]
# p12 = [NT::Mut::RABBIT_PAW, NT::Mut::EUPHORIA, NT::Mut::BOILING_VEINS]
# p a = [set, set2].map{NT::Mut.pack(_1 + p12)}
# p a.map{NT::Mut.unpack(_1).map{|m|NT.Mut(m)}.sort}

# p NT::Mut.unpack(8400410)
# print_sets

# eights = db.execute('SELECT date(jdate), score, muts FROM runs ORDER BY score DESC LIMIT 10000')
# pp eights.select{ |x| (NT::Mut.unpack(x[2]) - [NT::Mut::PATIENCE]).size == 8 }[0, 10]

# sevens = db.execute('SELECT date(jdate), score, muts FROM runs WHERE (muts >> ?) % 2 == 1 ORDER BY score DESC LIMIT 10000', NT::Mut::LAST_WISH)
# pp sevens.select{ |x| (NT::Mut.unpack(x[2]) - [NT::Mut::PATIENCE]).size == 8 }[0, 10]

# hearts = db.execute('SELECT t.*, username FROM (SELECT date(jdate), score, muts, "L" || loop || " " || stage, id FROM runs WHERE ultra IS NOT NULL ORDER BY score DESC LIMIT 100000) AS t JOIN players USING (id)')
# pp hearts.select{ |x| (NT::Mut.unpack(x[2]) - [NT::Mut::PATIENCE]).size == 7 }[0, 100]

# hearts_scores = db.execute('SELECT score, muts FROM runs WHERE ultra IS NOT NULL')
# scores = hearts_scores.select{ |x| (NT::Mut.unpack(x[1]) - [NT::Mut::PATIENCE]).size == 7 }.map(&:first)
# p sprintf('%.14f', scores.sum.to_r / scores.size)

# out = NT::Character.constants.map do |c|
#   db.execute('SELECT AVG(score) FROM runs WHERE RTRIM(character, "B") == ?', c.to_s.downcase)
# end
# p out

# puts table mut_count_by_day(db).sort_by{ |x| [x.last, x.first] }

# puts table deaths(74567, db)
# puts table deaths(135750, db)

# puts table deaths(nil, db)

# [NT::Player::DELTA].each do |id|
#   puts "#{id} #{db.execute('SELECT username FROM players WHERE id == ?', id).flatten.first}".ljust(40, ?=)
#   puts table mut_performance(id, db, true), ['Missing mut', 'Runs', 'Avg. score']
# end

# puts table mut_performance_diff(false, db)
# puts table mut_performance_diff(136555, db)
# puts table mut_performance_diff(359402, db), ['Mutation', 'runs', 'w/o', 'w/', 'diff']

# puts table print_killedby(136555, db).map{ |x| [x[0].empty? ? '[win]' : x[0], x[1]] }

# out = NT::Mut.constants.map do |c|
#   [c.to_s.tr(?_, ' ').title_case,
#     db.execute('SELECT COUNT(*), AVG(loop) FROM runs WHERE killedby IS NULL AND (muts >> ?) % 2 == 1',
#       NT::Mut.const_get(c)).flatten.then{ |x| [x[0], x[1].nil? ? 0 : x[1].round(2)] }
#   ].flatten
# end
# puts table out.sort_by{ |x| [-x[1], -x[2], x] }, ['Mutation', 'Wins', 'Avg. loops']

require 'prime'
a = db.execute('SELECT score FROM runs').map(&:first)
p a.count{_1.prime?}
p a.count(0)
p a.count(1)