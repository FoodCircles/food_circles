function change_view(vid,months_before){

    $.ajax({
        type: 'GET',
        url: '/monthly_invoice/new_layout?vid='+vid+'&months_before='+months_before,
        success: function(data) {

            if(data == "") {


                $("#new_layout").html("Nothing Found.");
            }
            else {
                $("#new_layout").html("");
                $("#new_layout").html(data);
            }
        }
    });

}
function change_request(vid,months_before,fee_message,fee_cost,input_note){

    $.ajax({
        type: 'GET',
        url: '/monthly_invoice/custom_invoice?vid='+vid+'&months_before='+months_before+'&fee_message='+fee_message+'&fee_cost='+fee_cost+'&input_note='+input_note,
        success: function(data) {

            if(data == "") {


                $("#new_layout").html("Nothing Found.");
            }
            else {
                $("#new_layout").html("");
                $("#new_layout").html(data);
            }
        }
    });

}