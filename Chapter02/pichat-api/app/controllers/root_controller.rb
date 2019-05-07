class RootController < ApplicationController
  skip_before_action :authorize_request, only: :index

  def index
    json_response(endpoints: [
      {
        path: "/auth/login",
        method: "GET",
        description: "Exchange credentials for an auth token",
        parameters: {
          email: "string",
          password: "string"
        }
      },
      {
        path: "/messages",
        method: "GET",
        description: "List all messages for the requesting user"
      },
      {
        path: "/messages",
        method: "POST",
        description: "Create a new message",
        parameters: {
          body: "The message body",
          user_id: "The user to send the message to"
        }
      },
      {
        path: "/messages/:id",
        method: "GET",
        description: "Retrieve a specific message"
      },
      {
        path: "/messages/:id",
        method: "PUT",
        description: "Update a specific message",
        parameters: {
          body: "The message body",
          user_id: "The user to send the message to"
        }
      },
      {
        path: "/messages/:id",
        method: "DELETE",
        description: "Delete a specific message"
      }
    ])
  end
end
