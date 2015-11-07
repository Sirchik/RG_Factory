require_relative 'Factory'

describe Factory do

  # p Struct.instance_methods false
  # p Factory.instance_methods false
  # p Struct.inspect
  # p Factory.inspect
  # CustomerS = Struct.new(:name, :address, :zip)
  # CustomerS1 = Struct.new(:name, :address, :zip)

  # p CustomerS.instance_methods false
  # # p CustomerS.send :members
  # CustomerF = Factory.new(:name, :address, :zip)
  # p CustomerF.instance_methods false
  # p CustomerS.inspect
  # joeS = CustomerS.new('Joe Smith', '123 Maple, Anytown NC', 12345)
  # p joeS.hash
  # joeS1 = CustomerS.new('Joe Smith', '123 Maple, Anytown NC', 12345)
  # joeF = CustomerF.new('Joe Smith', '123 Maple, Anytown NC', 12345)
  # p joeF.hash
  # # p joeS.values_at(0,2)
  # # p joeF.values_at(0,2)
  # p joeS == 123
  # p joeS.eql? joeS1
  # joeF1 = CustomerF.new('Joe Smith', '123 Maple, Anytown NC', 12345)

  # p joeS.select {|el| el.is_a?(String)}
  # p joeF.select {|el| el.is_a?(String)}
  # p joeF == joeF1
  # p joeF.class
  # p CustomerF.superclass
  # Struct.new("CustomerStringS", :name, :address, :zip)
  # Factory.new("CustomerString", :name, :address, :zip)
  # p Struct::constants
  # p Factory::constants
  # p constants

  context 'Customer from string' do
    it 'new CustomerString' do 
      Factory.new("CustomerString", :name, :address, :zip)
      expect(Factory::CustomerString.inspect).to eq 'Factory::CustomerString'
    end
  end

  context 'Customer' do

    before(:each) do
      CustomerF = Factory.new(:name, :address, :zip)
      @joeF = CustomerF.new('Joe Smith', '123 Maple, Anytown NC', 12345)
    end

    after(:each) do
      Object.send :remove_const, :CustomerF
    end

    it 'new Customer' do 
      expect(CustomerF.inspect).to eq 'CustomerF'
    end

    it 'Customer Class' do 
      expect(CustomerF.class).to eq Class
    end

    it 'Customer Class' do 
      expect(CustomerF.superclass).to eq Factory
    end

    it 'Customer members' do 
      expect(CustomerF.members).to eq [:name, :address, :zip]
    end

    it 'joe members' do 
      expect(@joeF.members).to eq [:name, :address, :zip]
    end

    it 'joe class' do 
      expect(@joeF.class).to eq CustomerF
    end

    it 'get joe.name' do 
      expect(@joeF.name).to eq 'Joe Smith'
    end

    it 'joe[:address]' do 
      expect(@joeF[:address]).to eq '123 Maple, Anytown NC'
    end

    it 'joe[2]' do 
      expect(@joeF[2]).to eq 12345
    end

    it 'joe.name = ' do 
      @joeF.name = 'Joe Smith jun'
      expect(@joeF.name).to eq 'Joe Smith jun'
    end

    it 'joe[:address] = ' do 
      @joeF[:address] = '321 Maple, Anytown NC'
      expect(@joeF[:address]).to eq '321 Maple, Anytown NC'
    end

    it 'joe[2] = ' do 
      @joeF[2] = 54321
      expect(@joeF[2]).to eq 54321
    end

    it 'joe[CustomerF]' do 
      expect {
        @joeF[CustomerF]
      }.to raise_error(TypeError)

    end

  end

  it 'Customer with block' do
    CustomerFb = Factory.new(:name, :address) do 
      def greeting
        "Hellow #{name}!"
      end
    end
    expect(CustomerFb.new("Dave", "123 Main").greeting).to eq "Hellow Dave!"
  end

end