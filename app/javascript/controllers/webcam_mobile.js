(function() {
    var width = 320; // We will scale the photo width to this
    var height = 0; // This will be computed based on the input stream

    var streaming = false;

    var video = null;
    var canvas = null;
    var photo = null;
    var startbutton = null;

    function startup() {
        video = document.getElementById('video');
        canvas = document.getElementById('canvas');
        photo = document.getElementById('photo');
        startbutton = document.getElementById('startbutton');
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

    function clearphoto() {
        var context = canvas.getContext('2d');
        context.fillStyle = "#AAA";
        context.fillRect(0, 0, canvas.width, canvas.height);

        var data = canvas.toDataURL('image/png');
        photo.setAttribute('src', data);
    }

    function takepicture() {
        var context = canvas.getContext('2d');
        if (width && height) {
            canvas.width = width;
            canvas.height = height;
            context.drawImage(video, 0, 0, width, height);

            var data = canvas.toDataURL('image/png');
            sessionStorage.setItem("mobile", data);
            // photo.setAttribute('src', data); remove if no need for image on same page
            // Dynamically get the current URL
            var baseURL = window.location.origin;
            var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
            fetch(baseURL+'/camera/mobile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken // Include CSRF token here
                },
                body: JSON.stringify({ image_data: data })
            })
            .then(response => response.json()
            )
            .then(data => {
                console.log('Success:', data);
                sessionStorage.setItem("extracted_mobile", data.result);
                window.location.href = '/proof_of_mobile';
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        } else {
            clearphoto();
        }
    }

    document.addEventListener('DOMContentLoaded', startup, false);

})();