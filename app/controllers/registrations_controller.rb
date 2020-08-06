class RegistrationsController < Devise::SessionsController
	respond_to :json
   
 def create
    resource = User.new(user_params)
 	if resource.save
 		render json: {message: "Successfully save", status: 200 }
 	else
 		msg = resource.errors.full_messages.join("<br>").html_safe
    render json: {message: msg, status: 401} 
 	end
 end 

 private 

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :contact_no, :dob, :auth_token, :avatar, :organization_id)
  end

end
