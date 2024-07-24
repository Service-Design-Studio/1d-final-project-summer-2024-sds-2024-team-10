require 'spec_helper'

describe 'Webcam functionality', type: :feature, js: true do
  before do
    visit '/upload/camera'  # Path to your webcam HTML page
  end

  it 'loads the webcam stream' do
    expect(page).to have_selector('#video')  # Checks if the video element has been set up
  end

  it 'takes a picture on button click' do
    find('#startbutton').click
    expect(page).to have_selector('#photo[src]', visible: :all)  # Checks if the photo element has received the image data
  end

  it 'displays result after taking a picture' do
    find('#startbutton').click
    # This sleep is to allow time for the image to be processed and response to be received
    # You might need to adjust the sleep duration depending on how quickly your server processes the image
    sleep(5)  # Adjust time as needed for your server's response time
    expect(page).to have_selector('#result', text: /\S+/, wait: 10)  # Checks for result text
  end
end
