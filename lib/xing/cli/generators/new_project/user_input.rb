require 'highline'

module Xing::CLI::Generators
  class NewProject
    class UserInput
      attr_accessor :code_of_conduct, :coc_contact_email

      def gather
        self.code_of_conduct = yesno("Add a Code of Conduct? (Contributor Covenant)")
        if code_of_conduct
          self.coc_contact_email = highline.ask("Enter a contact email for your Code of Conduct:") { |q| q.validate = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
        end
      end

      protected

      def highline
        @highline ||= HighLine.new
      end

      def yesno(prompt = 'Continue?', default = true)
        answer = ''
        options = default ? '[Y/n]' : '[y/N]'
        def_answer = default ? 'y' : 'n'
        until %w[y n].include? answer
          answer = highline.ask("#{prompt} #{options} ") { |q| q.limit = 1; q.case = :downcase }
          answer = def_answer if answer.length == 0
        end
        answer == 'y'
      end
    end
  end
end
