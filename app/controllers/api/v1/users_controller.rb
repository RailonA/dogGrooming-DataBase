class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: %i[auto_login index]
 
  def show
      @user = User.find(params[:id])
      @reserved_service = @user.services
      render json: { user: @user,
                     reserved_service: @reserved_service }
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: 201
      else
        render json: { errors: @user.errors.full_messages }, status: 422
      end
    end
  
    def login
      @user = User.find_by(username: params[:user][:username])
      if @user&.authenticate(params[:user][:password])
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: 200
      else
        render json: { error: 'Invalid Username or Password' }, status: 401
      end
    end

    private
  
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  end
  