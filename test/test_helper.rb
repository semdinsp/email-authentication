puts "in test helper"
require 'rubygems'
require 'bundler/setup'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start 
require 'stringio'
require 'minitest/autorun'
require 'minitest/unit'
SimpleCov.command_name 'test'
#SimpleCov.profiles.define 'mygem' do
#  add_group "Gem", '/lib/' # additional config here
#end
SimpleCov.start 

require File.dirname(__FILE__) + '/../lib/email-authentication'


