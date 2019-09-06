# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


# everything you make an update to this file (environment.rb) I will recommend restarting the server
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
