class UsersController < ApplicationController
	respond_to :json
	before_action :authenticate_user!, except: [:profile] 
  before_action :authenticate_request!

	def profile
		@current_user["avatar_data"] = @current_user.avatar_url
    render json: @current_user
	end
end
