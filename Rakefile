# frozen_string_literal: true

require "bundler/gem_tasks"
require "open3"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Gera a documentação YARD em doc/"
task :yard do
  sh "yard", "doc"
end

desc "Falha se a documentação YARD não estiver em 100%"
task :yard_stats do
  output, status = Open3.capture2e("yard", "stats", "--list-undoc")
  puts output
  abort("yard stats --list-undoc falhou") unless status.success?

  undocumented = output.scan(/\(\s*(\d+) undocumented\)/).flatten.map(&:to_i)
  fully_documented = undocumented.any? && undocumented.all?(&:zero?) && output.match?(/100(?:\.0+)?% documented/)
  abort("A documentação YARD não está em 100%.") unless fully_documented
end

task default: %i[spec yard_stats rubocop]
