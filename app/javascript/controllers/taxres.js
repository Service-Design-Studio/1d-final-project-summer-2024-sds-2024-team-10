document.addEventListener("DOMContentLoaded", function() {
    console.log("DOM fully loaded and parsed");
    var button = document.getElementById('nextButton');
    if (button) {
      button.addEventListener('click', function() {
        window.location.href = '/camera/identity';
      });
    }
    document.querySelectorAll('input[name="user[tax_resident]"]').forEach(function(el) {
        el.addEventListener('change', toggleTaxResidentFields);
    });
});

function toggleTaxResidentFields() {
    console.log("Radio button changed");
    var taxResidentFields = document.getElementById('tax-resident-fields');
    var isTaxResident = document.querySelector('input[name="user[tax_resident]"]:checked').value;
    if (isTaxResident === 'no') {
        taxResidentFields.style.display = 'block';
    } else {
        taxResidentFields.style.display = 'none';
    }
}
