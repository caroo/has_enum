require 'bundler/gem_tasks'

require 'rake'
require 'rake/testtask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the has_enum plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test:lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
