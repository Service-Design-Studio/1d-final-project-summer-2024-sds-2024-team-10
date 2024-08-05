let identity;
const width = 320; // We will scale the photo width to this
let height = 0; // This will be computed based on the input stream
let streaming = false;

let video = null;
let canvas = null;
let photo = null;
let startbutton = null;
let nextButton = null;

export function startup() {
    nextButton = document.getElementById('nextButton');
    video = document.getElementById('video');
    canvas = document.getElementById('canvas');
    photo = document.getElementById('photo');
    startbutton = document.getElementById('startbutton');
    nextButton.disabled = true;
    navigator.mediaDevices.getUserMedia({
            video: true,
            audio: false
        })
        .then(function(stream) {
            video.srcObject = stream;
            video.play();
        })
        .catch(function(err) {
            console.error("An error occurred: " + err);
        });
    video.addEventListener('canplay', function(ev) {
        if (!streaming) {
            height = video.videoHeight / (video.videoWidth / width);

            if (isNaN(height)) {
                height = width / (4 / 3);
            }

            video.setAttribute('width', width);
            video.setAttribute('height', height);
            canvas.setAttribute('width', width);
            canvas.setAttribute('height', height);
            streaming = true;
        }
    }, false);

    startbutton.addEventListener('click', function(ev) {
        takepicture();
        ev.preventDefault();
    }, false); 
    clearphoto();
}

export function clearphoto() {
    const context = canvas.getContext('2d');
    context.fillStyle = "#AAA";
    context.fillRect(0, 0, canvas.width, canvas.height);

    const data = canvas.toDataURL('image/png');
    photo.setAttribute('src', data);
}

export function takepicture() {
    const context = canvas.getContext('2d');
    if (width && height) {
        canvas.width = width;
        canvas.height = height;
        context.drawImage(video, 0, 0, width, height);

        const data = canvas.toDataURL('image/png');
        identity = "hi";
        const baseURL = window.location.origin;
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        fetch(baseURL + '/camera/identity', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify({ image_data: data })
        })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            document.getElementById('result').innerText = data.result;
            nextButton.disabled = data.enable;
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    } else {
        clearphoto();
    }
}

// Export the variable and functions
export { identity };