function convertRubyToJsonString(rubyString) {
    // Replace Ruby hash rocket => with colon :
    let jsonString = rubyString.replace(/=>/g, ':');
    
    // Replace single quotes with double quotes (if necessary)
    jsonString = jsonString.replace(/'/g, '"');
  
    return jsonString;
  }
document.addEventListener('DOMContentLoaded', function() {
    // Retrieve the base64 image data and text content from sessionStorage
    let data = sessionStorage.getItem("identity");
    let extracted_identity = sessionStorage.getItem("extracted_identity");
    // var button = document.getElementById('nextButton');
    // if (button) {
    //   button.addEventListener('click', function() {
    //     window.location.href = '/camera/employment';
    //   });
    // }
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
        let docutype = document.getElementById('docutype');
        let nationality = document.getElementById('nationality');
        let passport_expiry_date = document.getElementById('passport_expiry_date');
        let name = document.getElementById('name');
        let date_of_birth = document.getElementById('docutype');
        if (extracted_identity.includes('{')){
          temp = JSON.parse(convertRubyToJsonString(extracted_identity));
          // Set the text content of the result element
          docutype.value = temp["document_type"];
          nationality.value = temp["nationality"];
          passport_expiry_date.value = temp["passport_expiry_date"];
          name.value = temp["name"];
          gender.value = temp["gender"];
          date_of_birth.value = temp["date_of_birth"];
      }else {
        // Set the text content of the result element
        text.innerText = extracted_identity;
      }
    } else {
        console.log('No extracted identity data found in sessionStorage');
    }
});