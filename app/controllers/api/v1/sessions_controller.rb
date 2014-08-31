class Api::V1::SessionsController  < ApplicationController 
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  def create
    email = params[:email]
    password = params[:password]
    
    if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json"}
        return
    end
    
    if email.nil? or password.nil? 
      render :status=>400, :json=>{:message=>"The request must contain the user email and password."}
      return
    end
    
    @user=User.find_by_email(email.downcase)
    
    if @user.nil?
      logger.info("User #{email} failed signin, user cannot be found.")
      render :status=>401, :json=>{:message=>"Invalid email or passoword."}
      return
    end
    
    @user.ensure_authentication_token
    @user.save!
    
    if not @user.valid_password?(password) 
      logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:message=>"Invalid email or passoword."} 
    else
      render :status=>200, :json=>{:session=>@user.authentication_token, :email=>@user.email} 
    end
  end
  
  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Token not found.")
      render :status=>404, :json=>{:message=>"Invalid token."}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:session=>params[:id]}
    end
  end  

  # http://localhost:3000/api/v1/tokens to call by POST

end  
