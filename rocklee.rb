#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'nokogiri'

puts 'Enter URL: '
url = gets.chomp

puts 'Select format file: '
puts '[0] mp4'
puts '[1] mkv'
puts '[2] avi'
print 'Enter format: '
format = gets.chomp
if format == '0'
  format = "mp4"
elsif format == '1'
  format = "mkv"
elsif format == '2'
  format = "avi"
else
  puts "Invalid format"
end

fsize = format.length()


puts 'Select resolution: '
puts '[0] 1080p'
puts '[1] 720p'
puts '[2] 480p'
print 'Enter resolution: '
res = gets.chomp
if res == '0'
  res = "1080"
elsif res == '1'
  res = "720"
elsif res == '2'
  res = "480"
else
  puts "Invalid resolution"
end

uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
html = response.body
response = Nokogiri::HTML(html)
description = response.css("a")
links = description.map { |link| link['href'] }
links.each { |item|
  if item.to_s[0, 4] == "http" and item.to_s[-fsize, item.to_s.length] == format
    if item.include? res
      puts item
    end
  end
}
