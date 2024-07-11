# features/step_definitions/launch_and_select_steps.rb

Given("I visit the homepage and click on start" ) do
  visit '/'
  sleep 2
  visit '/signup'
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
  rescue Capybara::ElementNotFound
    raise "Some checkboxes were not found on the page"
  rescue StandardError => e
    raise "Error while checking checkboxes: #{e.message}"
  end
end

Given("I am on the checklist page") do
  visit '/checklist'
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
