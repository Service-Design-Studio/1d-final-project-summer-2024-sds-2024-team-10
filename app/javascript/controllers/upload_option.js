function onReady() {
    const camerabutton = document.getElementById('toCameraUpload');
    camerabutton.addEventListener("click",goToCameraUpload);
    }

function goToCameraUpload(){
    window.location.assign('/upload/camera');
}

if (document.readyState !== "loading") {
    onReady(); // Or setTimeout(onReady, 0); if you want it consistently async
} else {
    document.addEventListener("DOMContentLoaded", onReady);
}



