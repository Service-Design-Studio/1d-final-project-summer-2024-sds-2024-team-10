document.addEventListener("DOMContentLoaded", function() {
    console.log("DOM fully loaded and parsed");

    var button = document.getElementById('nextButton');
    var taxResidentFields = document.getElementById('tax-resident-fields');
    var taxResidentCountryField = document.getElementById('tax-resident-country');
    var tinField = document.getElementById('tin');

    // Initially disable the button
    button.disabled = true;

    // Add click event listener to the button
    if (button) {
        button.addEventListener('click', function() {
            window.location.href = '/camera/address';
        });
    }

    // Add change event listeners to radio buttons
    document.querySelectorAll('input[name="user[tax_resident]"]').forEach(function(el) {
        el.addEventListener('change', function() {
            toggleTaxResidentFields();
            updateNextButtonState(); // Update the button state when a radio button changes
        });
    });

    // Add input event listeners to text fields
    [taxResidentCountryField, tinField].forEach(function(el) {
        el.addEventListener('input', updateNextButtonState);
    });

    function toggleTaxResidentFields() {
        var isTaxResident = document.querySelector('input[name="user[tax_resident]"]:checked');
        if (isTaxResident && isTaxResident.value === 'no') {
            taxResidentFields.style.display = 'block';
        } else {
            taxResidentFields.style.display = 'none';
        }
        updateNextButtonState(); // Ensure the button state is updated when fields are shown/hidden
    }

    function updateNextButtonState() {
        var isTaxResident = document.querySelector('input[name="user[tax_resident]"]:checked');
        var isNoSelected = isTaxResident && isTaxResident.value === 'no';
        var allFieldsFilled = taxResidentCountryField.value.trim() !== '' && tinField.value.trim() !== '';

        if (isNoSelected) {
            // Enable the button only if all text fields are filled
            button.disabled = !allFieldsFilled;
        } else {
            // Enable the button if 'yes' is selected
            button.disabled = false;
        }
    }
});