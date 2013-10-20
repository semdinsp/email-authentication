#!/usr/bin/env ruby
require 'rubygems'
require 'email-authentication'
# needs upgrade to thor
 address=count = ARGV[0] 
 puts "Address is #{[address]}"
 @f=EmailAuthentication::Base.new
 success,msg=@f.check(address)
 puts "Success: #{address}" if success
 puts "Failure: #{address} messages: #{msg}" if !success