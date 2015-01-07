require 'sinatra'
require 'sinatra/reloader'
require 'mustache'
require './author.rb'
require './document.rb'
require './subscriber.rb'
require './project1_connection.rb'
require 'pry'
require 'active_record'

get ('/') do 
	docs = Document.all.entries
	Mustache.render(File.read('./index.html'), {docs: docs})
end	

get ('/create') do
	Mustache.render(File.read('./create_document.html'), {names: ["umer", "andy"]})

end	

post ('/create') do 
	Document.create({title: params["title"], content: params["content"], image: params["image"]})

	Author.create({name: params["name"]})

redirect '/create'
end

get ('/documents/:id') do

	doc = Document.find(params[:id])	
	Mustache.render(File.read('./doc_content.html'), {doc: doc})
	#can keep adding stuff in template you are using for this route
end



