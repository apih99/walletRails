class Rack::Attack
    throttle('req/ip', limit: 60, period: 1.minute) do |req|
        req.ip
    end

    throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
        if req.path == '/users/sign_in' && req.post?
            req.ip
        end
    end

    throttle('logins/email', limit: 5, period: 20.seconds) do |req|
        if req.path == '/users/sign_in' && req.post?
            req.params['user']['email'].to_s.downcase.strip if req.params['user'].present?
        end
    end

    self.throttled_response = ->(env) {
        [ 429,
        {'Content-Type' => 'application/json'},
        [{error: 'Throttle limit reached. Please try again later.'}.to_json]
        ]
    }
end