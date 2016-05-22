#!/usr/bin/ruby
#
# A script to check the output of a web page matches certain strings.
# Author: jonnytpuppet

require 'net/http'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: check_http [options]"

  opts.on('-s server', '--server server', 'server hostname or IP') do |host|
    options[:host] = host
  end

  opts.on('-p port', '--port port', 'Port') do |port|
    options[:port] = port
  end

  opts.on('-f file', '--file file', 'File path') do |file|
    options[:file] = file
  end

  opts.on('-c check_strings', '--check-string check_strings', Array, 'Quoted strings to check') do |check_strings|
    options[:check_strings] = check_strings
  end

  opts.on('-h', '--help', 'Display Help') do
    puts opts
    exit 3
  end
end.parse!

uri = URI("http://#{options[:host]}:#{options[:port]}/#{options[:file]}")
begin
  output = Net::HTTP.get(uri)
rescue
  puts 'CRITICAL: Cannot connect to web server'
  exit 2
end

missing_strings = []
options[:check_strings].each do |str|
  unless output.include?(str)
    missing_strings << str
  end
end

if missing_strings.empty?
  puts 'OK: All strings appear in web page'
  exit 0
else
  puts 'CRITICAL: The following strings do not appear in the output:'
  missing_strings.each do |str|
    puts str
  end
  exit 2
end