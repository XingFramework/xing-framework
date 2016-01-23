require 'architecture/dsl'

module Xing::CLI::Generators
  module Templaters
    class Templater

      include Architecture

      def initialize(target_name, context, control = false)
        @target_name = target_name
        @context = context
        @control = control
      end

      attr_reader :target_name, :context, :control

      def template
        if !control
          architecture source: File.expand_path('../../../../../../default_configuration/templates/', __FILE__) , destination: target_name  do |arc|
            template_files(arc)
          end
        end
      end
    end

    Dir[File.dirname(__FILE__) + '/templaters/*.rb'].each { |file| require file }
  end
end
