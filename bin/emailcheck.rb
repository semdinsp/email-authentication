#!/usr/bin/env ruby
require 'rubygems'
require 'email-authentication'
require 'thor'
# needs upgrade to thor
#puts "Check emailcheck.rb check  <address>  --from <from>"
 
class CheckEmailCLI < Thor
    desc "check", "check an email address to see if it is valid for mx, smtp and format usage: emailcheck.rb check  address --from fromadd"
    option :from, :required => true
    def check(address)
      puts "checking address => #{address}, from => #{options[:from]}"
      @f=EmailAuthentication::Base.new
      success,msg=@f.check(address,options[:from])
      if success
       puts "Success: #{address} messages #{msg}"
     else
       puts "Failure: #{address} messages: #{msg}"
     end
    end
    desc 'hello', "just print the command line"
    option :from, :required => true
    def hello(name)
        puts "from: #{options[:from]}" 
        puts "Hello #{name}"
      end
end

CheckEmailCLI.start(ARGV)


 