class Factory

  def self.new *args, &block
    # if args[0].is_a?(String)
    #   class_name = args.shift
    # end
    my_class = Class.new do 
      @@members = args

      define_method :initialize do |*arr|
        @vars = @@members.zip(arr).to_h
      end

      @@members.each do |v|
      
        define_method v do
          @vars[v]
        end

        define_method "#{v}=" do |new_value|
          @vars[v] = new_value
        end

      end
      
      define_method "#{:[]}=" do |index, new_value|
        @vars[get_elem_sym(index)] = new_value
      end

      define_method :[] do |index|
        @vars[get_elem_sym(index)]
      end

      define_method :inspect do
        vars_string = ''
        @vars.each { |key, value| vars_string += ', ' unless vars_string.empty?; vars_string += "#{key}=#{value}"}
        '#<factory ' + my_class.inspect + ' ' + vars_string + '>'
      end

      define_method :members do
        my_class.members
      end

      define_singleton_method :members do
        @@members
      end

      private

        def get_elem_sym index
          if index.is_a?(Numeric)
            @vars.keys[index.to_i]
          elsif index.is_a?(Symbol)
            index
          elsif index.is_a?(String)
            index.to_sym
          else
            fail TypeError, "No implicit conversion of #{index.class} into Integer"
          end
        end

      class_eval &block if block_given?

    end

    # self.const_set(class_name, my_class) if class_name

    my_class

  end

end