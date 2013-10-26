#!/usr/bin/env ruby
require 'rubygems'
require 'email-authentication'
require 'vtiger'
# needs upgrade to thor
puts "Check check_and_addvtiger.rb <address> <from> <url> <username> <key>"
  address = ARGV[0] 
  from=ARGV[1] 
  @url=ARGV[2]
  @username=ARGV[3]
  @key=ARGV[4]
   def setup_vtiger_internal
      api = {
           :username => @username,
           :key => @key,
           :url => @url,
           }
      @vtiger_cmd =Vtiger::Commands.vtiger_factory(api)
    end
  def addleademail(ln,co,email)
     options={'description' => "indonesia list"}
     hashv={}
     @vtiger_cmd.addleademail(options,ln,co,email,hashv)
  end
 puts "Address is #{[address]} From address [#{from}]"
 setup_vtiger_internal
 @f=EmailAuthentication::Base.new
 success,msg=@f.check(address)
 if success
   addleademail(@f.name,@f.domain,address)
   puts "Success: #{address} messages #{msg}" if success
 end
 
 puts "Failure: #{address} messages: #{msg}" if !success