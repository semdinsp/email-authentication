require 'rubygems'
#require 'dnsruby'
#include Dnsruby

# Use the system configured nameservers to run a query

module EmailAuthentication
  class Base
    attr_accessor :address, :mx, :message
  def debug
    true
  end
  def set_address(address)
    raise "address nil" if address==nil
    raise "address blank" if address==""
    self.address=address.to_s
    @flag=true
  end
  def check_format
   [true,"format ok"]
  end
  
  def resolver
    @resolver = String.new('fred') if @resolver==nil
  #  @resolver = Dnsruby::Resolver.new if @resolver==nil
    @resolver
  end
  
  def check_mx
    
    ret = self.resolver.query("google.com", Types.MX)
    [true,"mx ok"]
  end
  
  def check_smtp
     [true,"smtp ok"]
   end
  def check(address)
    self.set_address(address)
    @message=[]
    puts "checking #{@address}"
    ['format','mx','smtp'].each { |cmd| 
        cmdstring="check_#{cmd}"
        res,msg= self.send(cmdstring)
         @flag=@flag && res
         @message << msg }
  end
 
 

   end    # Class
end    #Module
