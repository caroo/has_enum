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

desc "Create coverage data"
task :coverage do
  sh 'bundle exec rcov -x test -x gems -I lib:test test/has_enum_test.rb'
end
