require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

task :default => :spec

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

desc "Pry"
task :pry do
  sh "pry -r ./lib/path2"
end

desc "benchmark"
task :benchmark do
  sh 'ruby benchmarks/*.rb'
end
