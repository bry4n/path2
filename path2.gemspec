$:.unshift File.expand_path('../lib', __FILE__)

require "rubygems"

Gem::Specification.new do |gem|
  gem.name          = "path2"
  gem.version       = "0.1.1"
  gem.author        = "Bryan Goines"
  gem.summary       = "..."
  gem.email         = "bryann83@gmail.com"
  gem.homepage      = "http://github.com/bry4n/path2"
  gem.files         = Dir['README.md', 'LICENSE', 'lib/**/*.rb']
end
