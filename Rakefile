#
# This file is part of the pinterest-ruby gem. Copyright (C) 2017 and above Shogun <shogun@cowtech.it>.
# Licensed under the MIT license, which can be found at http://www.opensource.org/licenses/mit-license.php.
#

require "bundler/gem_tasks"
require "rspec/core/rake_task"

# Compatibility layer for Rake 11.0
Rake.application.class.send(:alias_method, :last_comment, :last_description) unless Rake.application.respond_to?(:last_comment)

RSpec::Core::RakeTask.new("spec")

RSpec::Core::RakeTask.new("spec:coverage") do
  ENV["COVERAGE"] = "true"
end

RSpec::Core::RakeTask.new("spec:ci") do
  ENV["COVERAGE"] = "true"
  ENV["NO_COLOR"] = "true"
end

desc "Performs linting of the code using rubocop"
task "lint" do
  Kernel.exec("rubocop -ED lib")
end

desc "Generate the documentation"
task :docs do
  system("yardoc") || raise("Failed Execution of: yardoc")
end

desc "Get the current release version"
task :version, :with_name do |_, args|
  gem = Bundler::GemHelper.instance.gemspec
  puts [args[:with_name] == "true" ? gem.name : nil, gem.version].compact.join("-")
end

desc "Prepare the release"
task prerelease: ["spec:coverage", "docs"] do
  ["git add -A", "git commit -am \"Version #{Bundler::GemHelper.instance.gemspec.version}\""].each do |cmd|
    system(cmd) || raise("Failed Execution of: #{cmd}")
  end
end