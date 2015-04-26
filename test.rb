require './bouncer.rb'
class Foo
  include Bouncer
  callable_by Foo, def bar
    :bar
  end

  def baz
    bar
  end
end

Foo.new.baz
Foo.new.bar
