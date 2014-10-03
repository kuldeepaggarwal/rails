module ActiveRecord
  module SecureToken
    extend ActiveSupport::Concern

    module ClassMethods
      # Adds methods to set and reset unique and random value for the given
      # attribute.
      #
      # Example using Active Record.
      #
      #   # Schema: User(name:string, token:string)
      #   class User < ActiveRecord::Base
      #     has_secure_token :token
      #     # The method call with the attribute(+token+) will do the
      #     # following things:
      #     #
      #     # 1. It will generate a method +rekey_token!+ for re-generating
      #     # the token value and will save it into the database.
      #     # 2. It will add a +before_create+ callback which will set the
      #     # +token+ value.
      #     #
      #   end
      #
      #   user = User.new(name: 'Kuldeep Aggarwal')
      #   user # => #<User id: nil, name: "kuldeep Aggarwal", token: nil>
      #   user.save
      #   user # => #<User id: nil, name: "kuldeep Aggarwal", token: 'jVKb2NjxFlWJQb5B8guQTpIZPzErSmaC'>
      #   user.rekey_token!
      #   user # => #<User id: nil, name: "kuldeep Aggarwal", token: 'rcCXEcxJ3IDRM4HjBJo9OLLIs06jEk0E'>
      def has_secure_token(attribute)
        # Load securerandom only when has_secure_token is used.
        require 'securerandom'

        before_create "set_generated_#{ attribute }_key"

        define_method("rekey_#{ attribute }!") do
          send("set_generated_#{ attribute }_key")
          save!
        end

        define_method("set_generated_#{ attribute }_key") do
          self[attribute] = SecureRandom.urlsafe_base64(24)
        end

        private "set_generated_#{ attribute }_key"
      end
    end
  end
end
