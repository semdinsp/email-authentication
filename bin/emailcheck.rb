#!/usr/bin/env ruby
require 'rubygems'
require 'email-authentication'
 address=count = ARGV[0] 
 @f=EmailAuthentication::Base.new
 success,msg=@f.check(address)
 puts "Success: #{address}" if success
 puts "Failure: #{address} messages: #{msg}" if !success