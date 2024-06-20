function onReady() {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    const nextButton = document.getElementById('nextButton');

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