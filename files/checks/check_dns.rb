#!/usr/bin/ruby
#
# A script to check the output of a web page matches certain strings.
# Author: jonnytpuppet

require 'resolv'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: check_dns [options]"

  opts.on('-s server', '--server server', 'server hostname or IP') do |host|
    options[:host] = host
  end

  opts.on('-d domain', '--domain domain', 'Domain Name') do |domain|
    options[:domain] = domain
  end

  opts.on('-i ip', '--ip ip', 'IP Address') do |ip|
    options[:ip] = ip
  end

  opts.on('-h', '--help', 'Display Help') do
    puts opts
    exit 3
  end
end.parse!

resolver = Resolv::DNS.new(:nameserver => ["#{options[:host]}"],
                           :search => [],
                           :ndots => 1)

begin
  resolved_ip = resolver.getaddress(options[:domain]).to_s
rescue
  puts "CRITICAL: Cannot lookup domain name"
  exit 2
end

if resolved_ip.eql?(options[:ip])
  puts "OK: Domain resolves to correct IP"
  exit 0
else
  puts "CRITICAL: The domain does not resolve to the correct IP."
  puts "Should: #{options[:ip]}"
  puts "Actual: #{resolved_ip}"
  exit 2
end