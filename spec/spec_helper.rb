$:.unshift "lib"
require "path2"
require "minitest/autorun"
require 'fakefs'

%w(.vim lib examples/hello examples/world test/production.log).each do |path|
  FileUtils.mkdir_p "/dummy/#{path}"
end


