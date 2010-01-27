#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'
require 'application'

root_dir = File.dirname(__FILE__)
set :root,        root_dir
set :app_file,    File.join(root_dir, 'application.rb')
set :views,       File.join(root_dir, 'presentations')
disable :run

run Sinatra::Application

