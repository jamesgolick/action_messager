task :default => [:test]

desc "Run basic tests"
Rake::TestTask.new("test") { |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  t.warning = true
}
