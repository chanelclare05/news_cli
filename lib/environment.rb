# frozen_string_literal: true

require_relative "./news_cli/version"

require 'bundler'
Bundler.require

require_relative "./news_cli/api"
require_relative "./news_cli/cli"
require_relative "./news_cli/news"