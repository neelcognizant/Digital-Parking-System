$(document).ready(function () {
  // Validate Email Format
  function isValidEmail(email) {
    const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return pattern.test(email);
  }

  // ==== LOGIN FORM VALIDATION ====
  $('#login-section form').on('submit', function (e) {
    e.preventDefault();

    const email = $('#login-email').val().trim();
    const password = $('#login-password').val().trim();
    let valid = true;

    $('#loginMessage, #loginMessage1').text(''); // clear previous messages

    if (!email) {
      $('#loginMessage').text('Email is required.');
      valid = false;
    } else if (!isValidEmail(email)) {
      $('#loginMessage').text('Please enter a valid email.');
      valid = false;
    }

    if (!password) {
      $('#loginMessage1').text('Password is required.');
      valid = false;
    } else if (password.length < 6) {
      $('#loginMessage1').text('Password must be at least 6 characters.');
      valid = false;
    }

    if (valid) {
      // Simulate successful login (you should replace this with actual AJAX call if needed)
      // Example condition: allow login only if email = test@example.com and password = test123
      if (email === "test@example.com" && password === "test123") {
        window.location.href = "availability.html";
      } else {
        $('#loginMessage1').text('Invalid credentials. Try again.');
      }
    }
  });

  // ==== SIGNUP FORM VALIDATION ====
  $('#signup-section form').on('submit', function (e) {
    e.preventDefault();

    const email = $('#signup-email').val().trim();
    const password = $('#signup-password').val().trim();

    let errorMessages = [];

    if (!email) {
      errorMessages.push('Email is required.');
    } else if (!isValidEmail(email)) {
      errorMessages.push('Enter a valid email.');
    }

    if (!password) {
      errorMessages.push('Password is required.');
    } else if (password.length < 6) {
      errorMessages.push('Password must be at least 6 characters.');
    }

    if (errorMessages.length > 0) {
      alert(errorMessages.join('\n'));
    } else {
      alert('Signup successful!'); // You can replace this with AJAX POST
      toggleForm('login'); // Return to login
    }
  });
});
