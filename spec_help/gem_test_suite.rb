puts Dir::pwd
require 'test/unit'
begin
  require 'spec'
rescue LoadError
  false
end

class RSpecTest < Test::Unit::TestCase
  def test_that_rspec_is_available
    assert_nothing_raised("\n\n *  RSpec isn't available - please run: gem install rspec  *\n\n"){ ::Spec }
  end

  def test_that_specs_pass
    assert(system(*%w{spec -f e -p **/*.rb spec}),"\n\n *  Specs failed  *\n\n")
  end
end
