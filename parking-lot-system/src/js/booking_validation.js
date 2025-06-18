$(document).ready(function () {
  function isValidRegNumber(number) {
    const pattern = /^[A-Z]{2,3}-\d{3,4}$/;
    return pattern.test(number.toUpperCase());
  }

  function isValidPhone(phone) {
    const pattern = /^[\d\s+()-]{7,}$/;
    return pattern.test(phone);
  }

  function isFutureDate(dateString) {
    const today = new Date();
    const inputDate = new Date(dateString);
    return inputDate >= today.setHours(0, 0, 0, 0);
  }

  $('form').on('submit', function (e) {
    e.preventDefault(); 

    
    const vehicleType = $('#vehicleType').val();
    const regNumber = $('#regNumber').val().trim();
    const vehicleColor = $('#vehicleColor').val().trim();
    const driverName = $('#driverName').val().trim();
    const email = $('#email').val().trim();
    const phone = $('#phone').val().trim();
    const parkingDate = $('#parkingDate').val();
    const parkingTime = $('#parkingTime').val();
    const duration = $('#duration').val();
    const termsChecked = $('#terms').is(':checked');

    let errors = [];

    
    if (!vehicleType) errors.push("Please select a vehicle type");
    if (!isValidRegNumber(regNumber)) errors.push("Enter a valid registration number");
    if (!vehicleColor) errors.push("Vehicle color is required");
    if (!driverName) errors.push("Driver name is required");

    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))
      errors.push("Enter a valid email address.");
    if (!isValidPhone(phone)) errors.push("Enter a valid phone number");

    if (!parkingDate) {
      errors.push("Parking date is required");
    } else if (!isFutureDate(parkingDate)) {
      errors.push("Parking date must be current or future date");
    }

    if (!parkingTime) errors.push("Parking time is required.");
    if (!duration) errors.push("Please select the duration");

    if (!termsChecked) errors.push("You must agree to the terms and conditions");

    // === Output or Submit ===
    if (errors.length > 0) {
      alert("Please fix the following errors:\n\n" + errors.join('\n'));
    } else {
      alert("Booking successful!");
      $('form')[0].reset();
    }
  });
});
