#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'

get '/' do
  erb :"shrug-28jan2010/index"
end

