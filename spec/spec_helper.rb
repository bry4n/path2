$:.unshift "lib"
require "path2"
require 'rspec'
require 'mocha'
require 'fakefs'

%w(.vim lib spec bin).each do |path|
  FileUtils.mkdir_p "/dummy/#{path}"
end

FileUtils.mkdir_p "/dummy/lib/dummy"

FileUtils.touch "/dummy/lib/dummy/hello.rb"


