# "title","video","category","age"

require 'set'
require 'csv'

def make_db(file)
  csv  =  CSV.table(file, converters: nil).map(&:to_hash)
  hsh    =  Hash.new { |h, k| h[k] = Set.new }
  tags =  csv.each_with_object(hsh) { |e, o|  o[e[:age]] << e[:category] }
  ages =  tags.keys
  {
    tag: tags,
    age: ages,
    content: csv
  }
end

DB = {
        'video'     =>  make_db('db/video.csv'),
        'bilingual' =>  make_db('db/bilingual.csv'),
        'nse'       =>  make_db('db/nse.csv'),
        'ebook'     =>  make_db('db/ebook.csv')
      }

def get_content(type, cat, age)
  DB[type][:content].select { |e| (e[:category] == cat) && (e[:age] == age)}
end

def menu_tag(type, cat, age)
   DB[type][:tag][age].to_a.map { |e| "#{type}/#{cat}/" + e }
end

def menu_age(type, cat, age)
   DB[type][:age]
end

