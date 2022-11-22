require 'rack'
require_relative '../lib/controller_base'

class MyController < ControllerBase
  def go
    if req.path == "/cats"
      render_content("hello cats!", "text/html")
    else
      redirect_to("/cats")
    end
  end

  def render_content(content, content_type='text/html')
        #throw error if @rendered is truee
        res.write(content)
        res['Content-Type'] = content_type
        nil
  end

  def redirect_to(url)
        res.status = 302
        res['Location'] = url
  end




end
app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res).go
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

