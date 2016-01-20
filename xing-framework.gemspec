# coding: utf-8

require 'find'

Gem::Specification.new do |spec|
  spec.name		= "xing-framework"
  #{MAJOR: incompatible}.{MINOR added feature}.{PATCH bugfix}-{LABEL}
  spec.version		= "0.2.3"
  author_list = {
    "Evan Dorn" => 'evan@lrdesign.com',
    "Judson Lester" => "judson@lrdesign.com"
  }
  spec.authors		= author_list.keys
  spec.email		= spec.authors.map {|name| author_list[name]}
  spec.summary		= "Code generator tools for the Xing Framework."
  spec.description	= <<-EndDescription
    The Xing Framework is a hypermedia-enabled Rails + AngularJS web and mobile development platform.
    This gem contains the generator for initializing a new Xing project.
  EndDescription
  spec.executables = %w{ xing }

  spec.rubyforge_project= spec.name.downcase
  spec.homepage        = ""
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  # Do this: y$ (on line below to yank it)
  #          @" (to execute that as a command, in the spec.files array
  # !!find lib bin doc spec spec_help -not -regex '.*\.sw.' -type f 2>/dev/null
  spec.files		= %w[
    lib/xing.rb
    lib/xing/cli.rb
    lib/xing/cli/generators.rb
    lib/xing/cli/generators/new_project.rb
    bin/xing
    spec/null_spec.rb
    spec_help/spec_helper.rb
    spec_help/gem_test_suite.rb
  ]

  Find.find('default_configuration/base_app') do |path|
    Find.prune if File.basename(path)[0] == ?.
    next if File.directory?(path)
    next if path =~ /\.sw[a-e,g-z]/
    spec.files << path
  end

  spec.test_file        = "spec_help/gem_test_suite.rb"
  spec.licenses = ["MIT"]
  spec.require_paths = %w[lib/]
  spec.rubygems_version = "1.3.5"

  spec.has_rdoc		= true
  spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} Documentation"]

  spec.add_dependency("trollop", "~> 2.1")
  spec.add_dependency("caliph", "~> 0.3")
  spec.add_dependency("bundler", "~> 1.10")
  spec.add_dependency("architecture", "~> 6.1")
end
