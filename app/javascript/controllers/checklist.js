document.getElementById('checklistForm').addEventListener('submit', function(event) {
    console.log("asdasdasdasdasdasd")
    event.preventDefault();
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    let allChecked = true;
    
    checkboxes.forEach(checkbox => {
        if (!checkbox.checked) {
            allChecked = false;
        }
    });
    
    if (allChecked) {
        alert('All items checked! Proceeding to the next step.');
    } else {
        alert('Please check all items before proceeding.');
    }
});
