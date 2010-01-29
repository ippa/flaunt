#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'

get '/' do
  @dirs = Dir["presentations/*"].select { |file| File.directory?(file) }.map { |dir| File.basename(dir) }
  erb :"index"
end

get '/:presentation' do 
  @title = "#{params[:presentation]}!  [made with http://github.com/ippa/flaunt]"

  index = Dir["presentations/#{params[:presentation]}/index.*"].first
  content = open(index).read

  html = case File.extname(index)
    when ".erb"       then require 'erb';       ERB.new(content, 0, "%<>").result
    when ".haml"      then require 'haml';      Haml::Engine.new(content).render
    when ".textile"   then require 'RedCloth';  RedCloth.new(content).to_html
    when ".md"        then require 'maruku';    Maruku.new(content).to_html
  end
  
  erb html  # render the produced HTML with our layout.erb
end

