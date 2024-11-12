# Nnnes's TB scraper

***Important: This scraper does not work for the new website!*** However, if you have an old database file, you can still analyze it using these (or any other) scripts.

## Background

This is the script I used to pull stats from [the old thronebutt.com daily leaderboard archive](https://web.archive.org/web/20230601165123/https://thronebutt.com/archive/26052023/1) into a local database every day before the site disappeared on March 25, 2024. It would run automatically on my desktop PC a little after the daily reset at midnight UTC+0 and scrape all records from the most recent day saved in the database up to 2 days prior to the current day.

The most recent version of the database can be downloaded [from the Releases section (`tb.zip`)](https://github.com/Nnnes/old-TB-scraper/releases/tag/2024-03-23). It contains all daily runs from the beginning of the archive, 2016-02-21, up to and including 2024-03-23. I do not currently plan to update this file with new stats, even after the new website is fully up and running.

## Usage

You'll need a relatively up-to-date version of [Ruby](https://www.ruby-lang.org/en/) to run the `.rb` scripts.

`scraper.rb` is only included for historical interest; I have added a line that causes it to exit immediately if you try to run it now. It used the [`nokogiri` gem](https://rubygems.org/gems/nokogiri) to parse HTML and the [`sqlite3` gem](https://rubygems.org/gems/sqlite3) to read from and write to the database.

`stats.rb` also requires the [`sqlite3` gem](https://rubygems.org/gems/sqlite3). It contains utilities for working with the data — the mutations in particular, which are stored in a single INT as a bit field — in ways that would be much more tedious in pure SQL.

To run the SQL snippets, you can get a simple command line interface from [sqlite.org](https://sqlite.org/download.html) or use a GUI wrapper; I recommend [DB Browser for SQLite (DB4S)](https://sqlitebrowser.org). All snippets should work with DB4S; some may have minor syntax errors with table names when using the CLI. Please report any issues you have while running these.

The database download is not indexed. Many slow database queries will run a lot faster if you create indices for the columns you're working with at the cost of a bit of storage space. You are likely to see even more performance gains if you are able to migrate it to a column-oriented database like [DuckDB](https://duckdb.org). (It really should have been a DuckDB database from the start!)

## Database details

The database is organized into 4 tables:

* `errors`: Some pages in the archive consistently refused to load for unknown reasons. Stats from these pages are missing, and the pages in question are enumerated in this table.
* `metadata`: A single row containing the most recent date in the scraped data.
* `players`: Matches Thronebutt IDs to Steam usernames. Users from other platforms have blank names. These names were up-to-date at the time they were scraped. The first time I ran the scraper was around November 2022, so many names will be from that time period. If a user changed their name, it would only be updated to the new one if and when they submitted a new daily run. I did not store Steam IDs or keep track of old usernames after name changes.
* `runs`: The main part of the database. It contains 3706471 rows, each with the details of one run. Its columns are as follows:
  * `jdate`: The [Julian day number](https://en.wikipedia.org/wiki/Julian_day) of the run. A simple online converter for Julian day numbers can be found [here](https://ssd.jpl.nasa.gov/tools/jdc/#/jd). SQLite can convert to and from Julian days natively.
  * `rank`: The final rank of the run at the time of scraping. Rank could change after the fact if a player with a higher rank was banned.
  * `id`: The ID assigned to the player by Thronebutt at the time of the player's first daily or weekly submission. These were created in sequential order; older accounts had lower numbers.
  * `character`: The character played. Followed by `B` if the player used the B skin, e.g. `fishB`.
  * `loop`: The highest loop reached in the run.
  * `stage`: The stage reached in the run as displayed in-game, e.g. `1-3`, `0-1`, `3-?`, `HQ1`, `$$$`, etc.
  * `score`: The final sumbitted score of the run.
  * `ultra`: The internal ID of the active ultra mutation at the end of the run. `NULL` if the player died before getting one. Ultra IDs can be found in `lang.ini` in the `[Races]` section. The character ID and the ultra ID are concatenated, e.g. Horror's (ID 11) ultra Meltdown (ID 3) is 113.
  * `muts`: The final list of mutations taken by the player, packed into a bit field. Mutation IDs can be found in `lang.ini` under `[Skills]`. If a player only took Rhino Skin (ID 1) and then died, the value of this column would be 2¹ = 2. If a player took Rhino Skin (1), Plutonium Hunger (3), and Rabbit Paw (4) before dying, the value would be 2¹ + 2³ + 2⁴ = 2 + 8 + 16 = 26. Heavy Heart's in-game ID is 29, but it was 0 on Thronebutt; due to this bug, it (almost) never showed up on Thronebutt, so it (almost) never appears in the database. Patience does appear in the final list even if the Patience set is seen; Last Wish does not after visiting the jungle, just like in the in-game display.
  * `weapons`: The weapons held by the player at the time of death. Weapon IDs can be found in `lang.ini` under `[Weapons]`. The main-hand and off-hand weapon IDs are padded to 3 digits and concatenated, e.g. main-hand Super Plasma Cannon (ID 111) and off-hand Ultra Shovel (ID 92) would be 111092, and main-hand Rogue Rifle (ID 81) and no off-hand (ID 0) would be 81000.
  * `crown`: The internal ID of the active crown at the end of the run. Crown IDs can be found in `lang.ini` under `[Crowns]`.
  * `killedby`: The internal ID of the cause of death. `NULL` if the player successfully completed the run. Death cause IDs can be found in `lang.ini` under `[CauseOfDeath]`.

There has been no effort to clean up data that is obviously the result of a bug or a cheat, only to match Thronebutt's archive as closely as possible. For example, there are 99 runs in the database that ended in L0 1-* but have ultra mutations listed, 4 runs listed as having reached Loop 128, and 2 runs (including one by myself!) listed as having taken *every* mutation, including Heavy Heart.

There are 24583 runs (of 3706471 total, ~0.66%) that appeared both at the bottom of one page and the top of the next in the archive; these are also listed twice in the database. I suspect that these appeared "on top of" other runs, causing the same number of runs to not appear at all. There are also 1108 pages (of 126049 total, ~0.88%) that failed to load listed in the `errors` table.

You can find a `lang.ini` file (initially named `lang-example.ini`) included in the game files of the `ntt_development` beta in Steam or from the older [Nuclear Throne Together](https://yellowafterlife.itch.io/nuclear-throne-together) website.
