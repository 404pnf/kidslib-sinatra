# "title","video","category","age"

require 'set'
require 'csv'

def make_db(file)
  CSV.table(file, converters: nil).map(&:to_hash)
end

DB =  ['bilingual.csv',
       'nse.csv',
       'video.csv',
       'ebook.csv'
      ].reduce([]) { |a , e| a + make_db("db/#{e}") }

# 大分类没有出现在csv中，手工创建
TYPE =  {
           早教乐乐园: ['亲子游乐园', '益智动画片', '欢乐音乐屋', '成长故事书', '英语小剧场'],
           欢乐读书屋: ['儿童绘本', '经典小说', '寓言故事', '童话故事', '双语阅读', '有声故事'],
           快乐小课堂: ['新标准英语', '跟我学英语', '彩虹英语']
        }

# 先根据大分类过滤出来所有内容。因为这个过滤比较麻烦，因此单独个方法出来
def content_by_type(type)
  DB.select { |e| TYPE[type.intern].include?(e[:category]) }
end

def get_content(type, cat, age)
  content_by_type(type).select { |e| e[:age] == age }
end

def menu_cat(type, cat, age)
   content_by_type(type) #.select { |e| e[:age] == age }
                        .reduce(Set.new) {|a, e| a << e[:category] }
                        .to_a
end

def menu_age(type, cat, age)
   content_by_type(type).reduce(Set.new) {|a, e| a << e[:age] }
                        .to_a
end
