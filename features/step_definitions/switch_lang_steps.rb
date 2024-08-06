# features/step_definitions/launch_and_select_steps.rb

Given("I am on the homepage" ) do
  visit '/'
  sleep 2
end

When('I click on the language dropdown') do
  find('select[name="language"]').click
  sleep 2
end

When('I select {string} from the language dropdown') do |language|
  select language, from: 'language'
  sleep 2
end

Then("I should see the page content in Chinese") do
  expect(page).to have_content('中文')
  sleep 2
end

Then("I should see the page content in Tamil") do
  expect(page).to have_content('தமிழ்')
  sleep 2
end

When("I click on 注册Digibank") do
  find('#SignUpforDigibankButton').click
  sleep 2
end

Then("I click on டிஜிபாங்க் பதிவு செய்யவும்") do
  find('#SignUpforDigibankButton').click
  sleep 2
end

Then("I click on sign up for digibank") do
  find('#SignUpforDigibankButton').click
  sleep 1
end

Then("I continue without Singpass") do
  find('#toChecklistButtonNoSingpass').click
  sleep 1
end

Then("I land on the page to sign up for Singpass") do
  expect(page.current_path).to eq('/new_chi')
  sleep 1
end

Then ('I navigate to the checklist page, which is in Chinese, making it convenient for me to understand.') do
  expect(page).to have_content('Checklist page content in Chinese')
  sleep 2 # Adjust 'Checklist page content in Chinese' to match the expected content
end
Then ('I land on the sign up page for Singpass') do
  expect(page.current_path).to eq('/new')
  sleep 1

end
And ('I land on the Checklist page to verify my Documents') do
  visit '/checklist'
end

Then('I arrive at the Checklist page in Tamil, which helps me understand which documents to upload, allowing me to complete my application successfully.') do
  visit '/checklist_ta'
  sleep 1
end

Then('I arrive at the Checklist page in Chinese, which helps me understand which documents to upload, allowing me to complete my application successfully.') do
  visit '/checklist_chi'
  sleep 1
end

Then("I arrive on the page to sign up for Singpass") do
  expect(page.current_path).to eq('/new_ta')
  sleep 1
end

Then ('I realize malay is not an option') do
  sleep 1
end


Then ('the User is stuck in the application process') do
  sleep 1
end

When("I print the attributes of all checkboxes") do
  #puts "Current URL before action: #{page.current_url}"

  # Find all checkbox elements on the page
  checkboxes = all('input[type="checkbox"]', visible: :all, wait: 10)

  # Iterate through each checkbox and print its attributes
  checkboxes.each_with_index do |checkbox, index|
    #puts "Attributes of Checkbox #{index + 1}:"

    # Get all attributes of the checkbox using JavaScript
    attributes = page.evaluate_script("Array.from(arguments[0].attributes).reduce((attrs, attr) => { attrs[attr.name] = attr.value; return attrs; }, {});", checkbox.native)

    attributes.each do |name, value|
      puts "#{name}: #{value}"
    end
    puts "----------------------------------------"
  end

  puts "Current URL after action: #{page.current_url}"
end


Then('the Next button should be clickable and red') do
  # Check if the button is present
  unless has_selector?('#nextButton')
    raise "Expected 'Next' button to be present, but it was not found."
  end

  next_button = find('#nextButton')

  # Get all attributes using JavaScript execution
  attributes = page.execute_script(<<-JS, next_button.native)
    var element = arguments[0];
    var attrs = element.attributes;
    var result = {};
    for (var i = 0; i < attrs.length; i++) {
      result[attrs[i].name] = attrs[i].value;
    }
    return result;
  JS

  # Print each attribute and its value
  #attributes.each do |name, value|
  #  puts "#{name}: #{value}"
  #end

  # Check if the data-enabled attribute is true
end


Then('the Next button is disabled') do
  # Check if the button is present
  unless has_selector?('#nextButton')
    raise "Expected 'Next' button to be present, but it was not found."
  end

  next_button = find('#nextButton')

  # Get all attributes using JavaScript execution
  attributes = page.execute_script(<<-JS, next_button.native)
    var element = arguments[0];
    var attrs = element.attributes;
    var result = {};
    for (var i = 0; i < attrs.length; i++) {
      result[attrs[i].name] = attrs[i].value;
    }
    return result;
  JS

  # Print each attribute and its value
  #attributes.each do |name, value|
  #  puts "#{name}: #{value}"
  #end
end

Given('I check all the checkboxes') do
  begin
    checkboxes = all('input[type="checkbox"]', visible: :all, wait: 6)

    checkboxes.each do |checkbox|
      # Print attributes before interaction
      #puts "Attributes before interaction for checkbox with ID '#{checkbox[:id]}':"
      #puts checkbox['outerHTML']

      # Scroll to the checkbox to ensure it is interactable
      scroll_to(checkbox)

      # Click using JavaScript to ensure interaction
      page.execute_script('arguments[0].click();', checkbox)

      # Check if the checkbox is checked after clicking
      unless checkbox.checked?
        raise "Checkbox with ID '#{checkbox[:id]}' is not checked after click"
      end

      # Update the data-checked attribute to true
      page.execute_script("document.getElementById('#{checkbox[:id]}').setAttribute('data-checked', 'true');")

      # Print attributes after interaction
      checkbox = find("##{checkbox[:id]}", visible: :all) # Re-find after interaction
      #puts "Attributes after interaction for checkbox with ID '#{checkbox[:id]}':"
      #puts checkbox['outerHTML']
    end
    sleep 2
    click_button 'nextButton'
    sleep 2
  rescue Capybara::ElementNotFound
    raise "Some checkboxes were not found on the page"
  rescue StandardError => e
    raise "Error while checking checkboxes: #{e.message}"
  end
end

Given("I am on the checklist page") do
  puts "Navigated to: #{page.current_url}"
  sleep 2
end

Given ('I am on the checklist page displayed in Chinese according to my language preference') do
  visit '/checklist_chi'
  sleep 2
end

Given ('I am on the checklist page displayed in Tamil according to my language preference') do
  visit '/checklist_ta'
  sleep 2
end























#signup
And ("I land on the Sign up page") do
  visit '/signup'
end
When ("I enter a valid Name") do
  fill_in 'full_name', with: 'Moulik Pare'
  sleep 2
end
And ("I enter a valid Phone Number") do
  fill_in 'phone_number', with: '84285208'
  sleep 2
end
And ("I click the Get OTP button") do
  find('#GetOTPButton').click
  sleep 2
end
And ("I visit the OTP page") do
  sleep 2
end
Then ('I enter the OTP and press continue') do
  puts "Please enter the OTP: "
  sleep 3
  otp = STDIN.gets.chomp  # Use STDIN.gets to ensure it reads from the terminal
  sleep 2
  fill_in 'otp', with: otp
  sleep 4
  click_button 'Authenticate'

end
And ("I proceed to the next page") do
  sleep 2
  find('#toChecklistButtonNoSingpass').click
  sleep 2
end
Then ('I land on the info page') do
  sleep 2
end
And ('I fill in my address particulars and press next') do
  fill_in 'postal-code', with: '471774'
  sleep 1
  fill_in 'block-no', with: '774'
  sleep 1
  fill_in 'floor', with: '08'
  sleep 1
  fill_in 'unit-no', with: '203'
  sleep 1
  fill_in 'address-line-1', with: 'Bedok Reservoir View'
  sleep 1
  fill_in 'address-line-2', with: 'Bedok Reservoir road'
  sleep 1
end

And ('I fill in my particulars') do
  fill_in 'user_display_name', with: 'Pare Moulik'
  sleep 1
  fill_in 'user_password', with: '654321'
  sleep 1
  fill_in 'user_email', with: 'moulikpare@gmail.com'
  sleep 1
  sleep 1
end

Given('I am on the user form page') do
  visit new_user_path # Adjust the path to your actual form page
end

When('I select {string} from the {string} dropdown') do |option, dropdown|
  select(option, from: dropdown)
end

When('I click the {string} button') do |button|
  click_button(button)
  sleep 4
end

And ("I click the Next button") do
  click_button('nextButton')
  sleep 4

end
Given('I am not a Tax resident , I choose no') do
  choose(option: 'no')
end

When('I fill in {string} with {string}') do |field, value|
  sleep 1
  fill_in(field, with: value)
  sleep 2
end

Then ("I entered the wrong OTP and press continue") do
  puts "Please enter the OTP: "
  sleep 3
  otp = STDIN.gets.chomp  # Use STDIN.gets to ensure it reads from the terminal
  sleep 2
  fill_in 'otp', with: otp
  sleep 4
  click_button 'Authenticate'
  sleep 4
end
And ('I realize I do not know my TIN number and close the app') do
  sleep 1
end



#DOC UPLOAD
Given ("I am on the document upload page") do
  visit '/proof_of_identity'
  sleep 2
  visit current_path
  sleep 2
end

And ("I click on the camera button22 to take a picture of the document") do
  click_button 'toCameraUpload'
  sleep 1
end

Then ("I click on Take picture") do
  sleep 2
  visit current_path
  sleep 5
  click_button 'startbutton'
  sleep 5
end


And ("I get an error") do
  sleep 4
end

And ("I can see the information extracted") do
  sleep 4
end

And ("I am unable to proceed to the next step") do
  sleep 2
end

And ("I can proceed to the next step") do
  click_button 'nextButton'
end

# Given step to navigate to the work selection page
Given('I am on the work selection page') do
  visit '/work' # Replace with the actual path
  sleep 2
end

# Step to select an option from the work dropdown
When('I select {string} from the work dropdown') do |work_option|
  select work_option, from: 'work'
  sleep 2
end

# Step to select an option from the industry dropdown
When('I select {string} from the industry dropdown') do |industry_option|
  select industry_option, from: 'industry'
  sleep 2
end

# Step to verify the selected option from the work dropdown
Then('I should see {string} selected from the work dropdown') do |expected_work|
  selected_option = page.find('#work').find('option[selected]').text
  sleep 2
  expect(selected_option).to eq(expected_work)
end

# Step to verify the selected option from the industry dropdown
Then('I should see {string} selected from the industry dropdown') do |expected_industry|
  selected_option = page.find('#industry').find('option[selected]').text
  sleep 2
  expect(selected_option).to eq(expected_industry)
end


And ("I click the Next Button") do
  click_button 'nextButton'
end

And  ("I am unable to proceed to the next page") do
  sleep 2
end
