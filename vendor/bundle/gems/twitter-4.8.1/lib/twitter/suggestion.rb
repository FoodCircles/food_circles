require 'twitter/base'

module Twitter
  class Suggestion < Twitter::Base
    attr_reader :name, :size, :slug

    # @param other [Twitter::Suggestion]
    # @return [Boolean]
    def ==(other)
      super || attr_equal(:slug, other) || attrs_equal(other)
    end

    # @return [Array<Twitter::User>]
    def users
      @users ||= Array(@attrs[:users]).map do |user|
        Twitter::User.fetch_or_new(user)
      end
    end

  end
end
