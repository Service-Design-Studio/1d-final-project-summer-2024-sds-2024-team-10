(function() {
    document.addEventListener("DOMContentLoaded", function() {
        console.log("html loaded")
        document.querySelectorAll('input[name="tax_resident"]').forEach(function(el) {
            el.addEventListener('change', toggleTaxResidentFields);
        });
    });

    function toggleTaxResidentFields() {
        console.log("no selected")
        var taxResidentFields = document.getElementById('tax-resident-fields');
        var isTaxResident = document.querySelector('input[name="tax_resident"]:checked').value;
        if (isTaxResident === 'no') {
            taxResidentFields.style.display = 'block';
        } else {
            taxResidentFields.style.display = 'none';
        }
    }
})();