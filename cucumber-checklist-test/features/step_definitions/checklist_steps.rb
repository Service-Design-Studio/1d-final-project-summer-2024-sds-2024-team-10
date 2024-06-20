# features/step_definitions/checklist_steps.rb

require 'selenium-webdriver'

Before do
  @driver = Selenium::WebDriver.for :chrome
  @driver.manage.window.maximize
end

After do
  @driver.quit
end

APP_BASE_URL = 'http://127.0.0.1:8080/checklist'

Given('I am on the checklist page') do
  @driver.get(APP_BASE_URL)
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
  
      begin
        checkbox = @driver.find_element(:id, document_id)
      rescue Selenium::WebDriver::Error::NoSuchElementError => e
        raise "Element with id '#{document_id}' not found on the checklist page."
      end
  
      if item['Status'] == 'checked'
        checkbox.click unless checkbox.selected?
      else
        checkbox.click if checkbox.selected?
      end
    end
  end
  

Then('the Next button should be grayed out') do
  button = @driver.find_element(:id, 'nextButton')
  expect(button.enabled?).to be_falsey
  expect(button.attribute('class')).to include('grayed-out')
end

Then('the Next button should be clickable and red') do
  button = @driver.find_element(:id, 'nextButton')
  expect(button.enabled?).to be_truthy
  expect(button.attribute('class')).to include('clickable')
  expect(button.attribute('class')).to include('red')
end
