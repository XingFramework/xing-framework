require 'simplecov-json'
require 'cadre/simplecov'
require 'codeclimate-test-reporter'

SimpleCov.start do
  coverage_dir "corundum/docs/coverage"
  add_filter "./spec/"
  add_filter "./spec_help/"
  add_filter "/vendor/bundle/"
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::JSONFormatter,
    SimpleCov::Formatter::HTMLFormatter,
    Cadre::SimpleCov::VimFormatter,
    CodeClimate::TestReporter::Formatter
  ])
end
