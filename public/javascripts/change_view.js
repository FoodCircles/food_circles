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