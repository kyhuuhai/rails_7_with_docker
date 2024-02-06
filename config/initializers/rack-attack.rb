Rack::Attack.enabled = true || ENV['ENABLE_RACK_ATTACK'] || Rails.env.production?

if ENV['REDIS_URL'].present?
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: ENV['REDIS_URL'])
end

Rack::Attack.throttle('requests per IP', limit: 20, period: 1.minute) do |request|
  request.ip
end

# Lockout IP addresses that are hammering your login page.
# After 20 requests in 1 minute, block all requests from that IP for 1 hour.
Rack::Attack.blocklist('allow2ban login scrapers') do |req|
  # `filter` returns false value if request is to your login page (but still
  # increments the count) so request below the limit are not blocked until
  # they hit the limit.  At that point, filter will return true and block.
  Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 20, findtime: 1.minute, bantime: 1.hour) do
    # The count for the IP is incremented if the return value is truthy.
    (req.path == '/v1/sign_in' and req.post?) || (req.path == '/v1/sign_up' and req.post?)
  end
end
