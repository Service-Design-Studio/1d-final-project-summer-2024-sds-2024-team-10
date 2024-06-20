# features/step_definitions/checklist_steps.rb
require 'selenium-webdriver'
require 'capybara/cucumber'

Capybara.default_driver = :selenium_chrome

Before do
  @driver = Capybara.current_session.driver.browser
  @driver.manage.window.maximize
end

After do
  @driver.quit
end

APP_BASE_URL = 'http://127.0.0.1:8080/checklist'

Given('I am on the checklist page') do
  visit APP_BASE_URL
end

Given('I see the following checklist items:') do |table|
  table.hashes.each do |item|
    document_id = case item['Document']
                  when 'Passport' then 'passport'
                  when 'Proof of Employment' then 'employment'
                  when 'Proof of Residential Address' then 'address'
                  when 'Proof of Tax Residency' then 'tax'
                  when 'Proof of Mobile Ownership' then 'mobile'
                  else
                    raise "Unknown document: #{item['Document']}"
                  end
    checkbox = find(:css, "##{document_id}")
    if item['Status'] == 'checked'
      checkbox.set(true) unless checkbox.checked?
    else
      checkbox.set(false) if checkbox.checked?
    end
  end
end

Then('the Next button should be grayed out') do
  button = find_button('nextButton')
  expect(button[:disabled]).to be_truthy
  expect(button[:class]).to include('grayed-out')
end

Then('the Next button should be clickable and red') do
  button = find_button('nextButton')
  expect(button[:disabled]).to be_falsey
  expect(button[:class]).to include('clickable')
  expect(button[:class]).to include('red')
end
