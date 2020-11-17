# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :ensure_json_request, :authenticate_user!

  private

  def ensure_json_request
    return if request.format == :json

    render nothing: true, status: 406
  end

  def authenticate_user!
    authenticated_user_id = request.headers['x-authenticated-user-id']
    is_authenticated_request = !authenticated_user_id.nil?

    if is_authenticated_request
      @authenticated_user_id = authenticated_user_id
    else
      render nothing: true, status: 401
    end
  end
end
