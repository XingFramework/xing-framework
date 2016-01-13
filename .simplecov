require 'simplecov-json'
require 'cadre/simplecov'

SimpleCov.start do
  coverage_dir "corundum/docs/coverage"
  add_filter "./spec"
  add_filter "/vendor/bundle/"
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::JSONFormatter,
    SimpleCov::Formatter::HTMLFormatter,
    Cadre::SimpleCov::VimFormatter
  ]
end
