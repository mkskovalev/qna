# Load the Rails application.
require_relative 'application'

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
    domain: 'localhost'
}

# Initialize the Rails application.
Rails.application.initialize!
