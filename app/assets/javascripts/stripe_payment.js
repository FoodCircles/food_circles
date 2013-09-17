$(function() {
  $(document)
  .on('click', '#dealbuy', function(event){
  	event.preventDefault();
    var link = $(this);
    link.text("Processing...");

    if(link.data().submitToStripe){
      var card = {
        number:   $("#card-number").val(),
        expMonth: $("#exp-month").val(),
        expYear:  $("#exp-year").val(),
        cvc:      $("#cvc").val()
      }

      Stripe.createToken(card, function(status, response) {
      
        if(response.error) {
          console.log(status + " - " + response.error.message);
        }

        if (status === 200) {
          $("[name='stripe_token']").val(response.id)
          $("#dealform").submit()
        } else {
          $("a#dealbuy").text("Error!");
          $("#stripe-error-message").text(response.error.message)
          $("#credit-card-errors").show()
          $("#user_submit").attr("disabled", false)
        }
      });
    }else{
      $("#dealform").submit();
    }
  })
  .on('ajax:beforeSend', "#dealform", function(e, xhr, settings) {
    var signup_fields = $('.deal-payment #sign-up-form');
    if(signup_fields.is(":visible")){
      settings.data += "&" + $('.deal-payment #sign-up-form input').serialize();
    }
  })

  .on('ajax:complete', "#dealform", function(e, data, status, xhr) {
    var parsed_data = JSON.parse(data.responseText);
    if(parsed_data.error){
      $("a#dealbuy").text("Error!");
    }else if (parsed_data.redirect_to){
      window.location = parsed_data.redirect_to;
    }
  });
})
