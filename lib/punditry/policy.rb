module Punditry
  class Policy
    attr_reader :user, :resource

    def initialize(user, resource)
      @user = user
      @resource = resource
    end

    def index?
      false
    end

    def new?
      false
    end

    def create?
      false
    end

    def show?
      false
    end

    def edit?
      false
    end

    def update?
      false
    end

    def destroy?
      false
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope
      end
    end

    private
    def parent
      resource.instance_variable_get(:@association).owner if collection?
    end

    def collection?
      resource.is_a?(ActiveRecord::Associations::CollectionProxy)
    end
  end
end
