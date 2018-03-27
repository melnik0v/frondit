require 'spec_helper'

describe Frondit::Extractor do
  let(:service) { described_class.new(controller_instance, user, policy, config) }

  let(:controller_instance) { TestController.new }
  let(:user) { OpenStruct.new(name: 'name', role: 'role') }
  let(:policy) { TestPolicy }
  let(:config) { { only: %i[index? show?] } }

  it 'should get policy' do
    expect(service.call).to eq("index" => true, "show" => false)
  end
end
