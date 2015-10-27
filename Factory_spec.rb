require_relative 'Factory'

describe Factory do

  it 'Factory new' do

    CustomerS = Struct.new(:name, :address, :zip)
    p CustomerS
    CustomerF = Factory.new(:name, :address, :zip)
    p CustomerF

  end

end