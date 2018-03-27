# frozen_string_literal: true

require 'active_support/concern'
require 'frondit/base'
require 'frondit/extractor'
require 'frondit/error'
require 'frondit/version'
require 'gon'

module Frondit # :nodoc:
  extend ActiveSupport::Concern

  module ClassMethods # :nodoc:
    def frondit(policy_class, config = {})
      action_list        = {}
      action_list[:only] = config[:on] if config[:on].present?
      before_action action_list do
        policies = gon.policies
        policies ||= {}
        policies[policy_class.to_s.camelize] = Frondit::Extractor.new(self, current_user, policy_class, config).call
        gon.policies = policies
      end
    end
  end
end
