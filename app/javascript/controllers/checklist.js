function onReady() {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    const nextButton = document.getElementById('nextButton');
    const modalImages = document.querySelectorAll('.sample-image');
    const accordions = document.querySelectorAll('.accordion');

    accordions.forEach(acc => {
        acc.addEventListener('click', function() {
            // Get the panel associated with this button
            const panel = document.getElementById('panel_' + this.id.split('_')[1]);
            
            // Toggle the panel display
            if (panel.style.display === 'block') {
                panel.style.display = 'none';
            } else {
                panel.style.display = 'block';
            }
        });
    });

    modalImages.forEach(image => {
        image.addEventListener('click', function() {
            const modalId = this.dataset.target;
            const modal = document.getElementById(modalId);

            // Display the modal
            modal.style.display = 'block';
            // Close modal when close button or outside modal area is clicked
            const closeBtn = modal.querySelector('.close');
            closeBtn.onclick = function() {
                modal.style.display = 'none';
            };

            window.onclick = function(event) {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            };
        });
    });
    

    // Function to check if all checkboxes are checked
    const checkCheckboxes = () => {
        const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
        nextButton.disabled = !allChecked;
    };

    // Add change event listeners to each checkbox
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', checkCheckboxes);
    });



    // Initial check to set the button state correctly on page load
    checkCheckboxes();

}
if (document.readyState !== "loading") {
    onReady(); // Or setTimeout(onReady, 0); if you want it consistently async

} else {
    document.addEventListener("DOMContentLoaded", onReady);

}

