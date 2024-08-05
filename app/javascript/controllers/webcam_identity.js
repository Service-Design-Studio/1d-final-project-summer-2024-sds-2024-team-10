import { startup, takepicture, identity } from './function_identity.js';
let temp;
// Initialize the camera functionality
document.addEventListener('DOMContentLoaded', startup, false);

// Access the `identity` variable after taking a picture
document.getElementById('startbutton').addEventListener('click', function() {
    takepicture();
    temp = identity;
    console.log(temp)
}
);
export {temp};