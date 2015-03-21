require "pundit"

module Punditry
  module Controller
    extend ActiveSupport::Concern

    include Pundit

    included do
      after_action :verify_authorized
      after_action :verify_policy_scoped, only: :index
    end

    module ClassMethods
      def skip_authorization(options = {})
        skip_after_action(:verify_authorized, options)
        skip_after_action(:verify_policy_scoped, options)
      end
    end

    private
    def authorize!(resource)
      resource = policy_scope(resource) if resource.respond_to?(:to_a)
      authorize(resource) && resource
    end

    def whitelist(resource)
      params.permit(*policy(resource).permitted_attributes)
    end
  end
end
