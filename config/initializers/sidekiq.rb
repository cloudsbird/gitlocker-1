# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: 'rediss://:pc9032c51251fb0fff9eb30af0e91c334f81d1d350055aeb44e30474385d77c98@ec2-54-161-174-175.compute-1.amazonaws.com:27840' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'rediss://:pc9032c51251fb0fff9eb30af0e91c334f81d1d350055aeb44e30474385d77c98@ec2-54-161-174-175.compute-1.amazonaws.com:27840' }
end
