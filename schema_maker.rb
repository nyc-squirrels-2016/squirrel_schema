require 'sqlite3'
require 'byebug'

db = SQLite3::Database.new 'squirrel_schema.sql'

tables = [
  "CREATE TABLE IF NOT EXISTS squirrels (
    id integer primary key,
    name varchar
  );",
  "CREATE TABLE IF NOT EXISTS nests (
    id integer primary key,
    squirrel_id integer,
    tree_id integer,
    max_occupancy integer
  );",
  "CREATE TABLE IF NOT EXISTS trees (
    id integer primary key,
    lead_squirrel_id integer
  );"
]

tables.each do |table_sql|
  db.execute(table_sql)
end

%w{rocky nutso hairry}.each do |name|
  db.execute('INSERT INTO squirrels (name) VALUES (?);', name)
end

result = db.execute("SELECT count(*) FROM squirrels;")
puts "Result is: #{result}"

db.execute("SELECT * FROM squirrels WHERE name LIKE '%o%';") do |row|
  puts row[1]
end
