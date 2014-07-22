module Looker
  class Client

    # Methods for the Users API
    #
    # @see look TODO docs link
    module Users

      # List all Looker users
      #
      # This provides a dump of every user, in the order that they signed up
      # for Looker.
      #
      # @param options [Hash] Optional options. look TODO do we need options here?
      # @option options [Integer] :since The integer ID of the last User that
      #   you’ve seen.
      #
      # @see look TODO docs link
      #
      # @return [Array<Sawyer::Resource>] List of Looker users.
      def all_users(options = {})
        paginate "users", options
      end

      # Get a single user
      #
      # @param user [String] A Looker user id.
      # @option options [Hash] look TODO do we need options here?
      # @return [Sawyer::Resource]
      # @see look TODO docs link
      # @example
      #   Looker.user(1)
      def user(user=nil, options = {})
        if user
          get "users/#{user}", options
        else
          get 'user', options
        end
      end

      # Delete a single user
      #
      # @param user [String] A looker user id.
      # @return [Boolean] whether or not the delete succeeded
      # @option options [Hash] look TODO do we need options here?
      # @see look TODO docs link
      # @example
      #   Looker.delete_user(1)
      def delete_user(user=nil, options = {})
        boolean_from_response :delete, "users/#{user}", options
      end

      # Update a single user.
      #
      # @option user [String] id of user to update.
      # @param options [Hash] A customizable set of options.
      # @option options [String] :first_name
      # @option options [String] :last_name
      # @option options [String] :todo look TODO: Other options for user.
      # @return [Sawyer::Resource]
      # @see look TODO docs link
      # @example
      #   Looker.update_user(1, {:first_name => "Jonathan", :last_name => "Swenson"})
      def update_user(user, options = {})
        patch "users/#{user}", options
      end

      # Creates a credentials email for user
      #
      # @option options [Hash] A customizable set of options.
      # @option options [String] :first_name new user's first name
      # @option options [String] :last_name new user's last name
      # @option options [Boolean] :is_disabled whether or not a user is disabled
      # @option options [String] :todo look TODO: Other options for user.
      # @return [Sawyer::Resource]
      # @see look TODO docs link
      # @example
      #   Looker.create_user({:first_name => "Jonathan", :last_name => "Swenson"})
      def create_user(options = {})
        post 'users', options
      end

      # Creates credentials email associated with a user
      #
      # @param user [String] user id to create credentials email.
      # @param email [String] email address for new user.
      # @option options [Hash] A customizable set of options.
      # @option options [String] :todo look TODO: Other options for credentials email.
      # @return [Sawyer::Resource]
      # @see look TODO docs link
      # @example
      #   Looker.create_credentials_email(1, "jonathan@looker.com")
      def create_credentials_email(user, email, options = {})
        post "users/#{user}/credentials_email", options.merge(:email => email)
      end

      # updates credentials email associated with a user
      #
      # @param user [String] user id to update credentials email.
      # @option options [Hash] A customizable set of options.
      # @option options [String] :email new email for  user.
      # @option options [String] :todo look TODO: Other options for credentials email.
      # @return [Sawyer::Resource]
      # @see look TODO docs link
      # @example
      #   Looker.update_credentials_email(1, {:email => "jonathan+1@looker.com"})
      def update_credentials_email(user, options = {})
        patch "users/#{user}/credentials_email", options
      end

      # deletes credentials email associated with a user
      #
      # @param user [String] user id to delete credentials email.
      # @option options [Hash] A customizable set of options.
      # @option options [String] :todo look TODO: Other options for credentials email. Do we need options?
      # @return [Boolean] whether or not the delete succeeded
      # @see look TODO docs link
      # @example
      #   Looker.delete_credentials_email(9)
      def delete_credentials_email(user, options = {})
        boolean_from_response :delete, "users/#{user}/credentials_email", options
      end

      # gets credentials email associated with a user
      # @param user [String] user id associated with the credentials email to retrieve
      # @option options [Hash] A customizable set of options.
      # @option options [String] :todo look TODO: Other options for credentials email. Do we need options?
      # @return [Sawyer::Resource]
      # @see look TODO docs link
      # @example
      #   Looker.get_credentials_email(1)
      def get_credentials_email(user, options = {})
        get "users/#{user}/credentials_email", options
      end
    end

    private
    # convenience method for constructing a user specific path, if the user is logged in
    def user_path(user, path)
      if user == login && user_authenticated?
        "user/#{path}"
      else
        "users/#{user}/#{path}"
      end
    end
  end
end
