document.addEventListener('DOMContentLoaded', function() {
    // Retrieve the base64 image data and text content from sessionStorage
    let data = sessionStorage.getItem("employment");
    let extracted_identity = sessionStorage.getItem("extracted_employment");
    var button = document.getElementById('nextButton');
    if (button) {
      button.addEventListener('click', function() {
        window.location.href = '/camera/address';
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
        let text = document.getElementById('text');
        let name = document.getElementById('name');
        if (extracted_identity.includes('{')){
        temp = JSON.parse(convertRubyToJsonString(extracted_identity));
        // Set the text content of the result element
        name.value = temp["name"];
    }else {
        // Set the text content of the result element
        text.innerText = extracted_identity;
      }
    } else {
        console.log('No extracted identity data found in sessionStorage');
    }
});