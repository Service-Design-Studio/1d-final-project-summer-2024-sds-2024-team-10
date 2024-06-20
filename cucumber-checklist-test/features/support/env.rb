# features/support/env.rb

require 'capybara'
require 'capybara/cucumber'

# Set the default driver for Capybara
Capybara.default_driver = :selenium_chrome # Use :selenium_chrome for Chrome browser or :selenium for default Firefox browser

# Set the app host (change this to your local server URL)
Capybara.app_host = 'http://localhost:3000'  # Replace with your application's URL

# Optionally configure Capybara to wait for elements to appear on the page
Capybara.default_max_wait_time = 10  # Seconds to wait for elements to appear

# Configure Capybara to match the base URL of your application
Capybara.server_host = 'localhost'
Capybara.server_port = 3000

# Optionally configure a specific browser window size
# Capybara.current_session.driver.browser.manage.window.resize_to(1280, 1024)

# Optionally configure Capybara to use a specific browser
# Capybara.current_driver = :selenium_chrome_headless
