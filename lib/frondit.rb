# frozen_string_literal: true

require 'active_support/concern'
require 'frondit/base'
require 'frondit/extractor'
require 'frondit/error'
require 'frondit/version'

module Frondit # :nodoc:
  extend ActiveSupport::Concern

  module ClassMethods # :nodoc:
    def frondit(policy_class, config)
      action_list        = {}
      action_list[:only] = config[:on] if config[:on].present?
      before_action action_list do
        gon.policies               = {} if gon.policies.nil?
        gon.policies[policy_class] = Frondit::Extractor.new(self, current_user, policy_class, config).call
      end
    end
  end
end
