document.addEventListener("DOMContentLoaded", function() {
    var button = document.getElementById('nextButton');
    if (button) {
        button.addEventListener('click', function() {
          window.location.href = '/taxres';
        });
      }
});