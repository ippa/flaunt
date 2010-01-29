#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'

get '/' do
  @dirs = Dir["presentations/*"].select { |file| File.directory?(file) }.map { |dir| File.basename(dir) }
  erb :"index"
end

get '/:presentation' do 
  @title = "#{params[:presentation]}!  [made with http://github.com/ippa/flaunt]"
  erb :"#{params[:presentation]}/index"
end

