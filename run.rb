#!/usr/bin/env ruby
$:.unshift(File.expand_path('./lib', File.dirname(__FILE__)))
require 'highline/import'
require 'knight_api/runner'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: run.rb [options]"
  opts.on('-s','--start POSITION', String) do |position|
    options[:start] = position
  end

  opts.on('-d','--destination POSITION', String) do |position|
    options[:destination] = position
  end
  opts.on('-l', '--limit [LIMIT]', Integer) do |limit|
    options[:max_limit] = limit
  end
end.parse!

raise OptionParser::MissingArgument.new("start") unless options[:start]
raise OptionParser::MissingArgument.new("destination") unless options[:destination]

puts KnightApi::Runner.new.run(options)
