document.addEventListener('DOMContentLoaded', () => {
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

    // Prevent form submission and provide feedback
    document.getElementById('checklistForm').addEventListener('submit', function(event) {
        event.preventDefault();
        if (nextButton.disabled) {
            alert('Please check all items before proceeding.');
        } else {
            alert('All items checked! Proceeding to the next step.');
            // Here you can add code to actually proceed to the next step, e.g., submit the form
        }
    });
});
