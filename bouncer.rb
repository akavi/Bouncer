require 'binding_of_caller'

module Bouncer
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def callable_by(*args)
      if args.first.is_a? Symbol
        method_name = args.first
        klasses = args[1..-1]
      else
        method_name = args.last
        klasses = args[0...-1]
      end

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
