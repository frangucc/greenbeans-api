class Api::Merchant::PasswordsController < Devise::PasswordsController
  before_filter :set_headers
  
  def create
    respond_to do |format|  
      format.html { 
        super 
      }
      format.json {
        validate_resource_params('merchant', 'email')
        self.resource = resource_class.send_reset_password_instructions(resource_params)
        if successfully_sent?(resource)
          render :json => {status: 200, message: "Password reset instructions email has been sent."}
        else
          render :json => {status: 205, message: "Email not exist"}
        end
      }
    end
  end
  
  def set_headers
    if request.headers["HTTP_ORIGIN"] #&& /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  end
  
  rescue_from Exception do |exception|
    output = generate_exception_output(exception)
    render :json => output
  end
  
end
