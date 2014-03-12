require 'sinatra'
require_relative 'lib/lib.rb'

configure do
  enable :sessions
end

get '/' do
  session[:type] = 'video'
  session[:cat] = '欢乐音乐屋'
  session[:age] = '4-6岁'
  "try <a href='/content'>/content</a>"
end

get '/content' do
  redirect '/' if [session[:type], session[:cat], session[:age]].none?
  type, cat, age = session[:type], session[:cat], session[:age]
  r = {
        content:   get_content(type, cat, age),
        tag:  menu_tag(type, cat, age),
        age:  menu_age(type, cat, age)
      }
  "#{r}"
end

get '/session' do session.inspect end
get '/session-clear' do session.clear; redirect '/session' end



# 如果不使用sessino而是用url的restful方式
#
# get '/:type/:cat' do |type, cat|
#   r = DB[type][:content].select { |e| e[:category] == cat }
#   "#{r}"
# end

# get '/:type/:cat/:age' do |type, cat, age|
#   r = DB[type][:content].select { |e| (e[:category] == cat) && (e[:age] == age)}
#   content = get_content(type, cat, age)
#   menu_tags = generate_menu(type, cat, age)
#   menu_ages = DB[type][:age]
#   "#{menu_tags}<hr>#{menu_ages}<hr>#{content}"
#   #{}"#{type} #{cat} #{age}"
#   session.inspect
# end