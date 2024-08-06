function convertRubyToJsonString(rubyString) {
    // Replace Ruby hash rocket => with colon :
    let jsonString = rubyString.replace(/=>/g, ':');
    
    // Replace single quotes with double quotes (if necessary)
    jsonString = jsonString.replace(/'/g, '"');
  
    return jsonString;
  }
document.addEventListener('DOMContentLoaded', function() {
    // Retrieve the base64 image data and text content from sessionStorage
    let data = sessionStorage.getItem("mobile");
    let extracted_identity = sessionStorage.getItem("extracted_mobile");
    var button = document.getElementById('nextButton');
    if (button) {
      button.addEventListener('click', function() {
        window.location.href = '/camera/tax';
      });
    }
    // Check if image data exists
    if (data) {
        // Select the photo element
        let photo = document.getElementById('photo');
        // Set the src attribute of the photo element with the base64 data
        photo.setAttribute('src', data);
    } else {
        console.log('No image data found in sessionStorage');
    }

    // Check if text content exists
    if (extracted_identity) {
        // Select the result element
        let text = document.getElementById('text');
        let name = document.getElementById('name');
        let mobile = document.getElementById('mobile');
        if (extracted_identity.includes('{')){
        temp = JSON.parse(convertRubyToJsonString(extracted_identity));
        // Set the text content of the result element
        name.value = temp["name"];
        mobile.value = temp["mobile"];
    }else {
        // Set the text content of the result element
        text.innerText = extracted_identity;
      }
    } else {
        console.log('No extracted identity data found in sessionStorage');
    }
});