require 'uri'
require 'net/http'
require 'json'
require 'base64'
def generate_content(image_data, prompt_text)
  api_key = "AIzaSyBV5Mn_j1U2DMTvK-s2jvmgpbpxlteOhwg"
  uri_string = "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=#{api_key}"
  
  # image_data = File.read(image_path, mode: "rb")
  encoded_image = Base64.strict_encode64(image_data)

  body_request = {
    contents: [
      {
        parts: [
          { text: prompt_text },
          {
            inlineData: {
              mimeType: 'image/png',
              data: encoded_image #encoded_image
            }
          }
        ]
      }
    ]
  }.to_json

  req_uri = URI(uri_string)
  res = Net::HTTP.post(req_uri, body_request, "Content-Type" => "application/json")
  return JSON.parse(res.body)
  # puts JSON.parse(res.body)["candidates"][0]["content"]["parts"][0]["text"].split()[1]
end

# generate_content("../assets/images/mobile.jpg", "If the image is blurry, let me know, otherwise, Extract the phone number from this image and return it in as a key-value pair but not json")