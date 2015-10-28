require_relative 'Factory'

describe Factory do

  CustomerS = Struct.new(:name, :address, :zip)
  CustomerF = Factory.new(:name, :address, :zip)
  joeS = CustomerS.new('Joe Smith', '123 Maple, Anytown NC', 12345)
  joeF = CustomerF.new('Joe Smith', '123 Maple, Anytown NC', 12345)
  Factory.new("CustomerString", :name, :address, :zip)

  it 'new CustomerString' do 
    expect(CustomerString.inspect).to eq 'CustomerString'
  end

  it 'new Customer' do 
    expect(CustomerF.inspect).to eq 'CustomerF'
  end

  it 'Customer Class' do 
    expect(CustomerF.class).to eq Class
  end

  it 'Customer members' do 
    expect(CustomerF.members).to eq [:name, :address, :zip]
  end

  it 'joe members' do 
    expect(joeF.members).to eq [:name, :address, :zip]
  end

  it 'joe class' do 
    expect(joeF.class).to eq CustomerF
  end

  it 'get joe.name' do 
    expect(joeF.name).to eq 'Joe Smith'
  end

  it 'joe[:address]' do 
    expect(joeF[:address]).to eq '123 Maple, Anytown NC'
  end

  it 'joe[2]' do 
    expect(joeF[2]).to eq 12345
  end

  it 'joe.name = ' do 
    joeF.name = 'Joe Smith jun'
    expect(joeF.name).to eq 'Joe Smith jun'
  end

  it 'joe[:address] = ' do 
    joeF[:address] = '321 Maple, Anytown NC'
    expect(joeF[:address]).to eq '321 Maple, Anytown NC'
  end

  it 'joe[2] = ' do 
    joeF[2] = 54321
    expect(joeF[2]).to eq 54321
  end

  it 'joe[CustomerF]' do 
    expect {
      joeF[CustomerF]
    }.to raise_error(TypeError)

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