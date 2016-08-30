class Rack::App::Router::Static < Rack::App::Router::Base

  protected

  def fetch_context(request_method, request_path)
    app = mapped_endpoint_routes[[request_method, request_path]]
    app && {:app => app}
  end

  def mapped_endpoint_routes
    @mapped_endpoint_routes ||= {}
  end

  def clean_routes!
    mapped_endpoint_routes.clear
  end

  def compile_endpoint!(request_method, request_path, endpoint)
    mapped_endpoint_routes[[request_method.to_s.upcase, request_path]]= as_app(endpoint)
  end

  def compile_registered_endpoints!
    endpoints.each do |endpoint|
      compile_endpoint!(endpoint[:request_method],endpoint[:request_path], endpoint[:endpoint])
    end
  end

end
