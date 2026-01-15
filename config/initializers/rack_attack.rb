class Rack::Attack
  throttle("contact_form/ip", limit: 3, period: 60.minute) do |req|
    req.ip if req.path == "/contact" && req.post?
  end

  self.throttled_responder = lambda do |request|
    env = request.env
    request_headers = env["HTTP_ACCEPT"] || ""

    if request_headers.include?("application/json")
      Rails.logger.warn "Returning JSON response for throttled request"
      return [ 429, { "Content-Type" => "application/json" }, [ { error: "Too many requests. Please wait a moment." }.to_json ] ]
    end

    [ 429, { "Content-Type" => "text/html" }, [ "<h1>Too many requests. Please wait a moment.</h1>" ] ]
  end
end
