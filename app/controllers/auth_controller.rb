class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @admin = Admin.find_by(email: login_params[:email])
        if @admin && @admin.authenticate(login_params[:password])
            token = encode_token(admin_id: @admin.id)
            render json: { admin: @admin, jwt: token }, status: :accepted
        else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end 

    private

    def login_params
        params.require(:admin).permit(:email, :password)
    end

end