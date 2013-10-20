[![Build Status](https://travis-ci.org/semdinsp/email-authentication.png)](https://travis-ci.org/semdinsp/email-authentication)
[![Code Climate](https://codeclimate.com/repos/524654d9c7f3a31b29038e3a/badges/58ed8386e3e6d266c7ac/gpa.png)](https://codeclimate.com/repos/524654d9c7f3a31b29038e3a/feed)
[![Gem Version](https://badge.fury.io/rb/email-authentication.png)](http://badge.fury.io/rb/email-authentication)

NaySayers Read here
============

It is NOT possible to verify an email address unless you send an email to it.  And even then you may get a transient bounce.  This gem tries its best to check to see if the address is valid.  But is DOES NOT guarantee validity.  Then why this gem?  Because sometimes you receive a list of email addresses and you want to test them before adding to an email service provider list so your account is not blocked due to failing addresses.  This gem helps in that process

email-authentication gem
============

Given an email address, check to see if it is valid.  Check the structure of the address, MX record of the domain and if the domain accpts the SMTP connection

Usage case
=====================
Let's say you are using Amazon SES and you want to validate your email addresses before you send via SES (or any other provder).  Amazon is quite particular about bounce rates and cchecking prior to sending via SES can prevent your account from being blocked.

Use gem
=====================
To test an email address.  It returns boolean if success and a list of messages

    @f=EmailAuthentication::Base.new
    success,msgs=@f.check('an email adresss')
    

Use just a portion of gem
=====================
If you just want to use a portion of the gem (eg check_mx record)  then just set the address and call the check funciton

    @f=EmailAuthentication::Base.new
    @f.set_address(@success)
    success,msg= @f.check_format
