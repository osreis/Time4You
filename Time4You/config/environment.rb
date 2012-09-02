# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Time4You::Application.initialize!
WillPaginate::ViewHelpers.pagination_options[:renderer] = 'AjaxWillPaginate'