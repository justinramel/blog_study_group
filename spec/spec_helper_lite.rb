require 'rr'
require 'date'
require 'minitest/pride'

class MiniTest::Unit::TestCase
  include RR::Adapters::MiniTest
end

def stub_module(full_name)
  full_name.to_s.split(/::/).inject(Object) do |context, name|
    begin
      context.const_get(name)
    rescue NameError
      context.const_set(name, Module.new)
    end
  end
end
