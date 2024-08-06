document.addEventListener('DOMContentLoaded', function() {
    // Retrieve the base64 image data and text content from sessionStorage
    let data = sessionStorage.getItem("address");
    let extracted_identity = sessionStorage.getItem("extracted_address");
    var button = document.getElementById('nextButton');
    if (button) {
      button.addEventListener('click', function() {
        window.location.href = '/camera/mobile';
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
        let text = document.getElementById('result');
        // Set the text content of the result element
        text.innerText = extracted_identity;
    } else {
        console.log('No extracted identity data found in sessionStorage');
    }
});