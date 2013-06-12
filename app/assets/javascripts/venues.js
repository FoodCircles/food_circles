//= require home

$(function() {
    $('.bigButton').attr('data-active', 'false');
    $('tr').click(function() {
    	$('input:radio').prop('checked', false);
	$(this).find('input:radio').prop('checked', true);
        $('.bigButton').attr('data-active', 'true');
    });

    $('.bigButton').click(function() {
	if ($('input:radio:checked').length == 0) {
	    alert('Please select a perk.');
	} else {
	    o = $('input:radio:checked').attr('data-id');
	    window.location = "/app?v="+v+'&o='+o;
	}
        $(this).attr('data-active', 'false');
    });
});

$( function() {
    $.refreshScripts()
} )
