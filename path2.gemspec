$:.unshift File.expand_path('../lib', __FILE__)

require "rubygems"

Gem::Specification.new do |gem|
  gem.name          = "path2"
  gem.version       = "0.1"
  gem.author        = "Bryan Goines"
  gem.summary       = "A sophisticated version of Ruby library for searching files and directories"
  gem.email         = "bryann83@gmail.com"
  gem.homepage      = "http://github.com/bry4n/pathway"
  gem.files         = Dir['README.md', 'LICENSE', 'lib/**/*.rb']
end
