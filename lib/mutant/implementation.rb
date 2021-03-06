module Mutant
  class Implementation
    SINGLETON_SCOPE = '.'
    INSTANCE_SCOPE = '#'
    SCOPE_REGEXP = Regexp.union(SINGLETON_SCOPE, INSTANCE_SCOPE)

    def initialize(str)
      @str = str
    end

    def scope_type
      { SINGLETON_SCOPE => :singleton, INSTANCE_SCOPE => :instance
      }[method_scope]
    end

    def class_name
      @str.split(SCOPE_REGEXP)[0]
    end

    def method_scope
      @str[SCOPE_REGEXP]
    end

    def method_name
      @str.split(SCOPE_REGEXP)[1] if method_scope
    end

    def constant
      class_name.split(/::/).inject(Object) do |context, name|
        context.const_get name
      end
    end

    def all_implementations
      all_methods.map {|formatted_method| self.class.new(formatted_method)}
    end

    def all_methods
      all_singleton_methods + all_instance_methods
    end

    def all_singleton_methods
      constant.singleton_methods(false).delete_if {|meth_name|
        meth_name.to_s == '__class_init__' }.map {|meth_name|
          format_method(meth_name, SINGLETON_SCOPE)}
    end

    def all_instance_methods
      constant.instance_methods(false).map do |meth_name|
        format_method(meth_name, INSTANCE_SCOPE)
      end
    end

    def mutatees
      Array(method_scope ? self : all_implementations).map do |impl|
        Mutatee.new(impl)
      end
    end

    def to_s
      @str
    end

    private

    def format_method(meth_name, method_scope_type)
      class_name + method_scope_type + meth_name.to_s
    end
  end
end
