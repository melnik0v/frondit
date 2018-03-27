require 'spec_helper'

describe Frondit::Base do
  it 'should return initialization js' do
    expect(described_class.init)
      .to include(Gon::Base.render_data(need_tag: false))
      .and include('window.policies = function() { return window.gon.policies }')
      .and include('window.policy = function(name) { return window.gon.policies[name] }')
  end
end
