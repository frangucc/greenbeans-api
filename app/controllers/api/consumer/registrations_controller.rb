class Api::Consumer::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_merchant!
  before_filter :set_headers
  
  respond_to :json
  
  def create
    respond_to do |format|  
      format.html { 
        super 
      }
      format.json {
        build_resource
        if resource.save
          render :json => {status: 200, consumer: resource}
        else
          render :json => {status: 205, message: resource.errors.full_messages}
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
