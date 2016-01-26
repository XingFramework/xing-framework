require 'xing'
require 'architecture/dsl'

module Xing::CLI::Templaters
  class Templater

    include Architecture

    def initialize(target_name, context, guard = false)
      @target_name = target_name
      @context = context
      @guard = guard
    end

    attr_reader :target_name, :context, :guard

    def template
      if !guard
        architecture source: File.expand_path('../../../../default_configuration/templates/', __FILE__),
          destination: target_name  do |arc|
          template_files(arc)
        end
      end
    end
  end

  Dir[File.dirname(__FILE__) + '/templaters/*.rb'].each { |file| require file }
end
