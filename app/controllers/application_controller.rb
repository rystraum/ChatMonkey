class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user_from_http_basic!
  
  def authenticate_user_from_http_basic!
    if (request.authorization)
      authorization = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
      email = authorization[0]
      password = authorization[1]
    end
    
    user = User.find_for_authentication email: email
    if user && user.valid_password?(password)
      sign_in user, store: false
    end
  end
end
