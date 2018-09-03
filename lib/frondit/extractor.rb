# frozen_string_literal: true

require 'frondit/validator'

module Frondit
  class Extractor # :nodoc:
    include Validator

    EXCEPT_POLICY_METHODS = %i[user record].freeze

    def initialize(controller_instance, user, policy_class, config)
      @controller_instance  = controller_instance
      @user                 = user
      @policy_class_path    = policy_class
      @rules_to_check       = config[:only]
      @record_variable_name = config[:record].to_sym if config[:record]
    end

    def call
      validate!
      policies
    end

    private

    attr_reader :controller_instance, :user, :policy_class_path, :rules_to_check, :record_variable_name

    def policies
      policies_list.each_with_object({}) do |policy_name, h|
        h[policy_name.to_s.delete('?')] = policy.send(policy_name)
      end
    end

    def policies_list
      @policies_list ||= Array(rules_to_check || policy_rules)
    end

    def policy
      @policy ||= policy_class.new(user, record)
    end

    def policy_class
      return @policy_class_path if @policy_class_path.is_a? Class
      @policy_class ||= @policy_class_path.to_s.camelize.safe_constantize
    end

    def policy_rules
      @policy_rules ||= policy_class.ancestors.map! do |klass|
        next unless klass.to_s.include? "Policy"
        klass.instance_methods(false).reject { |method| EXCEPT_POLICY_METHODS.include? method }
      end.flatten.compact.uniq
    end

    def record
      return if record_variable_name.blank?
      @record ||= controller_instance.instance_variable_get(record_variable_name)
    end
  end
end
