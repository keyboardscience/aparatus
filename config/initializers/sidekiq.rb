Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/12', namespace: "aparatus" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/12', namespace: "aparatus" }
end
