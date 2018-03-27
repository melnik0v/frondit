require 'spec_helper'

describe Frondit do
  it 'add class method to TestController' do
    expect(TestController.methods.include?(:frondit)).to be_truthy
  end
end
