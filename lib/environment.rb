# frozen_string_literal: true

require_relative "./news_cli/version"

#this will load the gem file 
require 'bundler'
Bundler.require

require_relative "./news_cli/api"
require_relative "./news_cli/cli"
require_relative "./news_cli/news"


puts "in environment"