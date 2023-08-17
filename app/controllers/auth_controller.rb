class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
  
    def create
      user = find_user_by_email(login_params[:email])
      if user && user.authenticate(login_params[:password])
        token = encode_token(user_id: user.id, user_type: user.class.name.downcase)
        render json: { user: user, jwt: token }, status: :accepted
      else
        render json: { error: 'Invalid username or password' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.require(:user).permit(:email, :password)
    end
  
    def find_user_by_email(email)
      Admin.find_by(email: email) || Customer.find_by(email: email)
    end
  end
  