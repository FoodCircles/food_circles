$( function() {
    $(document).on('click', '#dealbuy', function(event){
	event.preventDefault();
        var card = {
            number:   $("#card-number").val(),
            expMonth: $("#exp-month").val(),
            expYear:  $("#exp-year").val(),
            cvc:      $("#cvc").val()
        }
        Stripe.createToken(card, function(status, response) {
            if (status === 200) {
                $("[name='stripe_token']").val(response.id)
                $("#dealform").submit()
            } else {
                $("#stripe-error-message").text(response.error.message)
                $("#credit-card-errors").show()
                $("#user_submit").attr("disabled", false)
            }
        });
    })
} )
