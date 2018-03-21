# frozen_string_literal: true

require 'action_view'
require 'gon'

module Frondit
  class Base # :nodoc:
    extend ActionView::Helpers::TagHelper

    class << self
      def init
        script_content = <<-SCRIPT
            #{Gon::Base.render_data(need_tag: false)}
            window.policies = () => window.gon.policies
            window.policy   = (name) => window.gon.policies[name]
        SCRIPT
        content_tag :script, script_content.html_safe, type: 'text/javascript'
      end
    end
  end
end
