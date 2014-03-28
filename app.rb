require 'sinatra'
require_relative 'lib/lib.rb'

configure do
  #enable :sessions
end

get '/' do
  erb :index
end

get '/content' do
  redirect '/' unless [request.cookies['type'], request.cookies['cat'], request.cookies['age']].all?
  type, cat, age = request.cookies['type'], request.cookies['cat'], request.cookies['age']
  erb :content ,  :locals => {  content:    get_content(type, cat, age),
                                cat:        menu_cat(type, cat, age),
                                age:        menu_age(type, cat, age)
                              }
end

get '/session'        do [request.cookies["type"], request.cookies["cat"], request.cookies["age"]].join(', ') end
get '/session-clear'  do session.clear; redirect '/session'   end
get '/*'              do redirect '/'                         end
