class SessionsController < Devise::SessionsController
	respond_to :json

	def create
		self.resource = warden.authenticate!(auth_options)
	  sign_in(resource_name, resource)
	  yield resource if block_given?
	  resource.auth_token = generate_auth_token(resource.id, resource.organization_id)
    if resource.save
	    render json: current_user.auth_token, status: 200
    else
      render json: {error: 'Invalid username / password'}, status: 400
    end
	  # response.headers["X-User-Token"] = resource.auth_token
	end

private

  def generate_auth_token id, organization_id
  	auth_token = JsonWebToken.encode({user_id: id, organization_id: organization_id})
  end
end

#curl  http://localhost:3002/ --Header "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.ryJ8Fvh4Q1E4Bjpqbn8sPz5wBYN8Gs0e5KclMFwzPwI"