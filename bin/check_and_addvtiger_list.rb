#!/usr/bin/env ruby
require 'rubygems'
require 'email-authentication'
require 'vtiger'
# needs upgrade to thor
# read file and add each line to database
puts "Check check_and_addvtiger_list.rb filename <from> <url> <username> <key>"
  filename = ARGV[0] 
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
     options={}
     hashv={'description' => "indonesia list" , 'leadsource'=> 'indonesia list'}
     @vtiger_cmd.addleademail(options,ln,co,email,hashv)
  end
 
 puts "Address is #{[address]} From address [#{from}]"
 setup_vtiger_internal
 @f=EmailAuthentication::Base.new
 File.open(filename).each do |line|
 address=line.chomp
 success,msg=@f.check(address,from)
      if success
      addleademail(@f.name,@f.domain,address)
      puts "Success: #{address} messages #{msg}" if success
    end
 
    puts "Failure: #{address} messages: #{msg}" if !success
 end