Gem::Specification.new do |s|
  s.name        = "email-authentication"
  s.version     = "0.1.0"
  s.author      = "Scott Sproule"
  s.email       = "scott.sproule@ficonab.com"
  s.homepage    = "http://github.com/semdinsp/email-authentication"
  s.summary     = "Simple gem to try and authenticate email address"
  s.description = "Try and authenticate email address, check format, lookup mx record and check smtp connectivity"
  s.executables = ['emailcheck.rb']    #should be "name.rb"
  s.files        = Dir["{lib,test}/**/*"] +Dir["bin/*.rb"] + Dir["[A-Z]*"] # + ["init.rb"]
  s.require_path = "lib"
  s.license = 'MIT'
  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
  s.add_runtime_dependency "dnsruby"
end
