$(document).ready(function() {

  var $email_reg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i
  
  $("button.signup").on("click", function(event){
    event.preventDefault();
  
    if ($("ul.errors li").length != 0) {
      $("ul.errors li").remove();
    };

    if ($email_reg.test($("form.signup input[name='email']").val()) == false) {
      $("ul.errors").append('<li>Invalid Email.</li>')
    };

    if ($("ul.errors li").length == 0) {
      $.ajax({
        url: "/signup",
        type: "post",
        data: $("form.signup").serialize()
      }).done(function (response) {
        $("div.new_user_welcome").append("<p>Welcome, your account has been successfully created.<br>Sign in for some awesome!</p>")
      }); 
    }
  });

  $("form.new_event").on("submit", function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr("action"),
      type: $(this).attr("method"),
      data: $(this).serialize()
    }).done(function (response) {
      $("ul.user_event_list").append("<li>" + response + "</li>")
    });
  });

});
