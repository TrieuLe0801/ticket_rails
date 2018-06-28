module Api
  module V1
  	class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: %i[login register]
	  def register
	  	@user = User.create(user_params)
	  	
	  	

	  
	  	if @user.save
	  	  response = {message: 'User created successfully'}
	  	  render json: response , status: :created
	  	else
	  		# @ary = Array.new
	  		# @user.errors.each do |e| 
     #         @ary.push e
	  		# end
	  	  render json: @user.errors, status: :bad
	  	end
	  end

	  def login
        authenticate params[:name], params[:password]
      end

      def max
      
        render json: {
              message: 'You have passed'
         }
   	  end


   	   def authenticate(name, password)
         command = AuthenticateUser.call(name, password)
    
         if command.success?
           render json: {access_token: command.result,
            			  message: 'Login Successful'}
         else
           render json: { error: command.errors }, status: :unauthorized
         end
       end 	
	  	
	  	private 

	  	  # def user_params
      #       params.require(:user).permit(:name, :email, :password)
    	 #  end
	  
		  def user_params
	        params.permit(
	          :name,
	          :email,
	          :password
	      	  )
	      end
	end
  end
end

