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
	Author.create({name: params["name"]})
	author_id = Author.last.id
	Document.create({title: params["title"], content: params["content"], image: params["image"], author_id: author_id })
	redirect '/create'
end

get ('/documents/:id') do

	doc = Document.find(params[:id])	
	Mustache.render(File.read('./doc_content.html'), {doc: doc})
	#can keep adding stuff in template you are using for this route
end

get ('/documents/:id/edit') do
	doc = Document.find(params[:id])
	author = Author.find(doc.author_id)
	Mustache.render(File.read('./document_edit.html'), {doc: doc, author: author })
end	

put ('/documents/:id/edit') do
	doc = Document.find(params[:id])
	author = Author.find(doc.author_id)
	author.update(name: params[:name])
	doc.update(title: params["title"], content: params["content"], image: params["image"])
	author.save
	doc.save
	redirect("/documents/#{params[:id]}")
end	

delete ('/documents/:id') do
	doc = Document.find(params[:id])
	doc.destroy
	redirect '/'
end	

# get ('/documents/:id/edit') do
# 	doc = Document.find(params[:id])



