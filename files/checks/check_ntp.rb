#!/usr/bin/ruby
#
# A script to check a NTP server
# Author: jonnytpuppet

require 'net/ntp'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: check_ntp [options]"

  opts.on('-s server', '--server server', 'server hostname or IP') do |host|
    options[:host] = host
  end

  opts.on('-h', '--help', 'Display Help') do
    puts opts
    exit 3
  end
end.parse!

begin
  result = Net::NTP.get(options[:host])
rescue
  puts "CRITICAL: Cannot connect to NTP server"
  exit 2
end

if result.client_time_receive && result.client_time_receive.to_s =~ /([0-9]{10})\.([0-9]{7})/
  puts "OK: Received response and time from NTP server."
  exit 0
else
  puts "CRITICAL: Did not receive a valid time from the NTP server."
  exit 2
end