# "title","video","category","age"

require 'set'
require 'csv'

def make_db(file)
  csv  =  CSV.table(file, converters: nil).map(&:to_hash)
  #hsh    =  Hash.new { |h, k| h[k] = Set.new }
  #tags =  csv.each_with_object(hsh) { |e, o|  o[e[:age]] << e[:category] }
  #ages =  tags.keys
  # {
  #   #tag: tags,
  #   #age: ages,
  #   content: csv
  # }
  CSV.table(file, converters: nil).map(&:to_hash)
end

# DB =   {
#           'video'     =>  make_db('db/video.csv'),
#           'bilingual' =>  make_db('db/bilingual.csv'),
#           'nse'       =>  make_db('db/nse.csv'),
#           'ebook'     =>  make_db('db/ebook.csv')
#         }
DB =   make_db('db/video.csv') + make_db('db/bilingual.csv') + make_db('db/nse.csv') + make_db('db/ebook.csv')
TYPE =  {
           早教乐乐园: ['亲子游乐园', '益智动画片', '欢乐音乐屋', '成长故事书', '英语小剧场'],
           欢乐读书屋: ['儿童绘本', '经典小说', '寓言故事', '童话故事', '双语阅读', '有声故事'],
           快乐小课堂: ['新标准英语', '跟我学英语', '彩虹英语']
        }

def get_content(type, cat, age)
  #DB[type][:content].select { |e| (e[:category] == cat) && (e[:age] == age)}
  DB.select { |e| TYPE[type.intern].include?(e[:category]) && e[:age] == age }
end

def menu_tag(type, cat, age)
   DB[type][:content].select { |e| e[:age] == age }
                     .reduce(Set.new) {|a, e| a << e[:category] }
                     .to_a
end

def menu_age(type, cat, age)
    DB[type][:content].reduce(Set.new) {|a, e| a << e[:age] }
                      .to_a
end

