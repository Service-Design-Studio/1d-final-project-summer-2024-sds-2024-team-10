function onReady() {
    const camerabutton = document.getElementById('toCameraUpload');
    const filebutton = document.getElementById('toFileUpload');
    camerabutton.addEventListener("click",goToCameraUpload);
    filebutton.addEventListener("click",goToFileUpload);
    }

function goToCameraUpload(){
    window.location.assign('/upload/camera');
}
function goToFileUpload() {
    window.location.assign('/upload/files');
}

if (document.readyState !== "loading") {
    onReady(); // Or setTimeout(onReady, 0); if you want it consistently async
} else {
    document.addEventListener("DOMContentLoaded", onReady);
}



