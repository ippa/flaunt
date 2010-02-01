#!/usr/bin/ruby

class Flaunt < Sinatra::Base
  @root_dir = ::File.dirname(__FILE__)
  set :root,        @root_dir
  set :views,       ::File.join(@root_dir, 'presentations')

  get '/?' do
    @base = env["SCRIPT_NAME"] || "/"
    views = File.join(File.dirname(__FILE__), 'presentations')  
    @dirs = Dir["#{views}/*"].select { |file| File.directory?(file) }.map { |dir| File.basename(dir) }
    erb :"index"
  end

  get '/:presentation' do
    @base = env["SCRIPT_NAME"] || "/"
    views = File.join(File.dirname(__FILE__), 'presentations')  
    @title = "#{params[:presentation]} - [ Made with http://ippa.se/flaunt ]"

    template = Dir["#{views}/#{params[:presentation]}/index.*"].first
    content = Tilt.new(template).render

    #
    # The core of Flaunt:
    #
    # 1) Take generated HTML, split at <hr>
    # 2) Wrap each block with <div class="slide">block here</slide> which can be styled with jquery/css
    #
    final_content = ""
    content.split(/\<hr.+\>/).each do |part|
      next if part =~ /\A\s+\Z/ # Skip part if it's empty (only containing space)
  
      final_content += "<div class=\"slide\">\n"
      final_content += part
      final_content += "\n</div>"
    end
  
    erb final_content


    #
    # Sinatra < 1.0 - Before tilt
    #
    # content = open(template).read
    # html = case File.extname(index)
    #   when ".erb"       then require 'erb';       ERB.new(content, 0, "%<>").result
    #   when ".haml"      then require 'haml';      Haml::Engine.new(content).render
    #   when ".textile"   then require 'RedCloth';  RedCloth.new(content).to_html
    #   when ".md"        then require 'maruku';    Maruku.new(content).to_html
    # end
    # erb html  # render the produced HTML with our layout.erb
  end
end
