class ApplicationController < ActionController::API
  include ActionController::Cookies

rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
#run authorize method before anything else runs 
before_action :authorize 

private
#@ creates an instance variable so the current user will be available across the whole session. when authorize we do our find by of the instance of the application controller so it is passed to the other controllers 
def authorize 
  @current_user = User.find_by(id: session[:user_id])
  
  render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user 
  end

def render_unprocessable_entity_response(exception)
 render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity 
end



end
