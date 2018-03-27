class TestController < ActionController::Base
  include Frondit
  before_action -> { @variable = OpenStruct.new(allow: false) }
  frondit TestPolicy

  def index; end
end
