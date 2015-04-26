require 'binding_of_caller'

module Bouncer
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def method_added(method_name)
      super
      return unless @call_scope
      wrap_method(method_name, @call_scope)
    end

    def callable_by_any
      @call_scope = nil
    end

    def callable_by(*args)
      if args.first.is_a? Symbol
        method_name = args.first
        klasses = args[1..-1]
      elsif args.last.is_a? Symbol
        method_name = args.last
        klasses = args[0...-1]
      else 
        @call_scope = args
        return
      end

      wrap_method(method_name, klasses)
    end


    def wrap_method(method_name, klasses)
      method_name_base, punctuation = method_name.to_s.sub(/([?!=])$/, ''), $1
      with_method = "#{method_name_base}_with_bouncer#{punctuation}"
      without_method = "#{method_name_base}_without_bouncer#{punctuation}"

      define_method(with_method) do |*args|
        kaller = binding.of_caller(1).receiver
        unless klasses.include? kaller.class
          raise NoMethodError.new("protected method #{method_name.to_s} called for #{self}")
        end

        send(without_method, *args)
      end

      alias_method without_method, method_name
      alias_method method_name, with_method
    end
  end
end
