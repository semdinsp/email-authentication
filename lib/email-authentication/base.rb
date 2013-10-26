require 'rubygems'
require 'dnsruby'
include Dnsruby
require 'net/telnet'

# Use the system configured nameservers to run a query

module EmailAuthentication
  class Base
    attr_accessor :address, :mx, :message, :domain, :from
  def debug
    true
  end
  def self.check(address,from)
    tmp=self.new
    return tmp.check(address,from)
  end
  def set_address(address,from="")
    raise "address nil" if address==nil
    raise "address blank" if address==""
    raise "from address blank" if from==""
    self.address=address.to_s
    self.from=from
    @flag=true
  end
  # this needs work.  Anyone who can improve the regex i would be happy to put in their changes
  # see alsothe validate_email_format gem for rails
  def check_format
    @@email_regex = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Z‌​a-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i
    res=(@address =~ @@email_regex)
    #puts " res is #{res}"
    if res
      [true,"format ok"]
    else
      [false,"format failed"]
    end
  end
  # cache the dns resolver
  def resolver
    @resolver = Dnsruby::Resolver.new if @resolver==nil
    @resolver
  end
  # check the mx domain
  def check_mx
    domain=self.address.split('@')
    @domain = domain[1]
    #puts "domain is #{domain}"
    flag=false
    if @domain!=nil
          begin
           ret = self.resolver.query(@domain, Types.MX)
            if ret.answer!=nil and ret.rcode=='NOERROR'
              @mx=ret.answer.first.exchange.to_s if ret.answer!=nil
              @mx=@mx.downcase
              msg= "mx record #{self.mx}"
              puts msg
              flag=true
            end
           rescue Dnsruby::NXDomain 
             msg="non existing domain #{@domain}"
             puts msg
           end
        
    else
      msg="nil domain"
    end
    # puts "ret is #{ret.inspect}"
    [flag,msg]
  end
  # need to think about this and check the domain via telnet
  #S: 220 smtp.example.com ESMTP Postfix
  #C: HELO relay.example.org
  #S: 250 Hello relay.example.org, I am glad to meet you
  #C: MAIL FROM:<bob@example.org>
  #S: 250 Ok
  #C: RCPT TO:<alice@example.com>
  #S: 250 Ok
  
  def check_smtp
      flag=false
      msg='smtp ok'
      domain=self.from.split('@')
      @fromdomain = domain[1]
      if @mx.include?('google') or @mx.include?('live.com')
         flag=true
         msg="smtp not checked since google or live: #{@mx}"
      else
        begin 
          smtp = Net::Telnet::new("Host" => @mx, 'Port' => 25, "Telnetmode" => false, "Prompt" => /^\+OK/)
          c=""
          msg=c
          cmd="HELO " + @fromdomain
          smtp.cmd('String' => cmd, 'Match'=> /^250/) { |c| print "CMD: #{cmd} RESP: #{c}" 
                 msg << c}
          cmd="MAIL FROM:<" +@from+ ">"
          sleep 0.5
          smtp.cmd('String' => cmd, 'Match'=> /^250/ ) { |c| print "CMD: #{cmd} RESP: #{c}" 
                   msg << c}
          cmd="RCPT TO:<" +@address+ ">"
          sleep 0.5
          smtp.cmd('String' => cmd, 'Match'=> /^250/ ) { |c| print "CMD: #{cmd} RESP: #{c}" 
                           msg=c
                           flag=true if c.include?('250') }
          cmd='quit'
          smtp.cmd('String' => cmd, 'Match'=> /^221/ ) { |c| print "CMD: #{cmd} RESP: #{c}"           }
        rescue Exception => e
          @flag=false
          msg= "smtp exception #{e.message}"
        end
      end
      
     [flag,msg]
   end
   # run all the checks
  def check(address,from)
    self.set_address(address,from)
    @message=[]
    puts "checking #{@address}"
    ['format','mx','smtp'].each { |cmd| 
        cmdstring="check_#{cmd}"
        res,msg= self.send(cmdstring)
         @flag=@flag && res
         @message << msg }
    [@flag,@message.join(',').to_s]
  end
 
 

   end    # Class
end    #Module
