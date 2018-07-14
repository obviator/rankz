# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    address: ENV.fetch('smtp_address'),
    port: ENV.fetch('smtp_port'),
    authentication: ENV.fetch('smtp_authentication'),
    user_name: ENV.fetch('smtp_user_name'),
    password: Rails.application.credentials.smtp_password,
    domain: ENV.fetch('smtp_domain'),
    enable_starttls_auto: ENV.fetch('smtp_enable_starttls_auto')
}

