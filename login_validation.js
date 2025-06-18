$(document).ready(function () {
  $("#loginForm").on("submit", function (e) {
    e.preventDefault();

    const username = $("#login-email").val().trim();
    const password = $("#login-password").val().trim();

    if (username === "" || password === "") {
      $("#loginMessage").text("Please fill in all fields.").show();
      return;
    }

    if (username === "admin" && password === "1234") {
      $("#loginMessage").css("color", "green").text("Login successful!");

      setTimeout(function () {
        window.location.href = "availability.html";
      }, 1500);
    } else {
      $("#loginMessage").css("color", "red").text("Invalid credentials");
    }
  });
});
