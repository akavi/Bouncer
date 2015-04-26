# Bouncer

Finer grained method visibility for Ruby.

Ruby's method visibility is a little bit restrictive. There's `public` and `private`, which are pretty blunt tools, either allowing *everyone* to call a method, or *no one* but the instance (There's also `protected`, whose entire purpose seems to be to facilitate comparison operators and... not much else). 

This lack of granularity isn't all that much different from other languages, but Ruby gives us the power to change that. Mostly. Bouncer's a module that when `include`ed on a class, lets you make a method callable visible to a subset of possible callers, depending on their class. 

## Example

Using Rails as our starting point, perhaps you have some methods on a model that you only want called from the Controllers, and not other models.

```ruby
class MyModel < ActiveRecord::Base
  include Bouncer

  callable_by ActionController::Base, def some_controller_only_method
    puts "I can't be called by a model!"
  end
end
  
```


