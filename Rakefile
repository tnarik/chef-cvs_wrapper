#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'foodcritic'

RSpec::Core::RakeTask.new(:spec)

desc 'Runs Foodcritic linter'
task :foodcritic do
  FoodCritic::Rake::LintTask.new do |t|
    t.options = { exclude_paths: ['spec'],
                  tags: ['~FC001']
    }
  end
end

task default:  %w[foodcritic spec]