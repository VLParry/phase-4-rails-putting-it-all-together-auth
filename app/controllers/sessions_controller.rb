class SessionsController < ApplicationController
   #everything below besides create needs to go through auth, so you need to be logged in to log out and do other stuff 
    skip_before_action :authorize, only: :create 
   #for user login feature 
    def create 
        user = User.find_by(username: params[:username])
        #authenticate below, the params we pass in have the password and the user knows about the digest hash, when you authenticate it compares the password they put in (encrypt) to whats in the digest. if user exists and authenticates, save in the session hash
        if user&.authenticate(params[:password])
            session[:user_id] = user.id 
            render json: user
        else
            render json: { errors: ["Invalid username or password"]}, status: :unauthorized
        end
    end

    #for user log out feature 
    def destroy 
        session.delete :user_id 
        head :no_content 
     end
end