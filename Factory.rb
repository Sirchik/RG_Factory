class Factory

  def self.new *args, &block
    if args[0].is_a?(String)
      class_name = args.shift
    end
    my_class = Class.new(self) do #(self)
      @@members = args

      define_method :initialize do |*arr|
        @values = args.zip(arr).to_h
      end

      define_singleton_method :new do |*args|
        inst = allocate
        inst.send :initialize, *args
        inst
      end

      define_method :values do
        @values.values
      end

      alias_method :to_a, :values

      define_method :values_at do |*keys|
        keys_sym = []
        keys.each{|el| keys_sym << get_elem_sym(el)}
        @values.values_at(*keys_sym)
      end

      @@members.each do |v|
      
        define_method v do
          @values[v]
        end

        define_method "#{v}=" do |new_value|
          @values[v] = new_value
        end

      end
      
      define_method "#{:[]}=" do |index, new_value|
        @values[get_elem_sym(index)] = new_value
      end

      define_method :[] do |index|
        @values[get_elem_sym(index)]
      end

      define_method :inspect do
        values_string = ''
        @values.each {|key, value| values_string += ', ' unless values_string.empty?; values_string += "#{key}=#{value.inspect}"}
        '#<factory ' + my_class.inspect + ' ' + values_string + '>'
      end

      alias_method :to_s, :inspect

      define_method :members do
        my_class.members
      end

      define_singleton_method :members do
        @@members
      end

      define_method :== do |other|
        if other.class == self.class
          values == other.values
        else
          false
        end
      end

      alias_method :eql?, :==

      define_method :to_h do
        @values
      end

      define_method :size do
        @values.size
      end

      alias_method :length, :size

      define_method :each do |&block|
        values.each(&block)
      end

      define_method :each_pair do |&block|
        @values.each(&block)
      end

      define_method :select do |&block|
        values.select(&block)
      end

      define_method :hash do
        super
      end

      private

        def get_elem_sym index
          if index.is_a?(Numeric)
            @values.keys[index.to_i]
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

    const_set(class_name, my_class) if class_name

    my_class

  end

end