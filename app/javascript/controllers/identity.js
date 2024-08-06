function onReady() {
    const camerabutton = document.getElementById('toCameraUpload');
    camerabutton.addEventListener("click",goToCameraUpload);
    }

function goToCameraUpload(){
    window.location.assign('/camera/identity');
}

if (document.readyState !== "loading") {
    onReady(); // Or setTimeout(onReady, 0); if you want it consistently async
} else {
    document.addEventListener("DOMContentLoaded", onReady);
}