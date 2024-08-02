function onReady() {
    const camerabutton = document.getElementById('toCameraUpload');
    camerabutton.addEventListener("click",goToCameraUpload);
    }

function goToCameraUpload(){
    const currentPath = window.location.pathname;
    const newPath = `/upload${currentPath}`;
    
    window.location.assign(newPath);
}

if (document.readyState !== "loading") {
    onReady(); // Or setTimeout(onReady, 0); if you want it consistently async
} else {
    document.addEventListener("DOMContentLoaded", onReady);
}