[![Build Status](https://travis-ci.org/semdinsp/email-authentication.png)](https://travis-ci.org/semdinsp/email-authentication)
[![Code Climate](https://codeclimate.com/repos/524654d9c7f3a31b29038e3a/badges/58ed8386e3e6d266c7ac/gpa.png)](https://codeclimate.com/repos/524654d9c7f3a31b29038e3a/feed)
[![Gem Version](https://badge.fury.io/rb/email-authentication.png)](http://badge.fury.io/rb/email-authentication)

email-authentication gem
========================

Given an email address, check to see if it is valid.  Check the structure of the address, MX record of the domain and if the domain accepts the SMTP connection and the recipient address.  Checking the smtp connection is unique to this gem that I am aware of.

NaySayers Read here
===================

It is NOT possible to verify an email address unless you send an email to it.  And even then you may get a transient bounce.  This gem tries its best to check to see if the address is valid.  But is DOES NOT guarantee validity.  Then why this gem?  Because sometimes you receive a list of email addresses and you want to test them before adding to an email service provider list so your account is not blocked due to failing addresses.  This gem helps in that process

Alternatives
============
See validates_email_format_of gem


Usage case
=====================
Let's say you are using Amazon SES and you want to validate your email addresses before you send via SES (or any other provider).  Amazon is quite particular about bounce rates and checking your list prior to sending via SES can prevent your account from being blocked.

Simplest usage 
=====================
To test an email address via a class call.  It returns boolean if success and a list of messages

    success,msgs=EmailAuthentication::Base.check('an email adresss','from address')

Use gem
=====================
To test an email address.  It returns boolean true if success and a list of messages from the tests.  The messages are primarily used to check on where the address is failing.

    @f=EmailAuthentication::Base.new
    success,msgs=@f.check('an email adresss','from address')
    

Use just a portion of gem
=====================
If you just want to use a portion of the gem (eg check_mx record)  then just set the address and call the check function (also see check_smtp)

    @f=EmailAuthentication::Base.new
    @f.set_address('to address',"from address")
    success,msg= @f.check_mx
