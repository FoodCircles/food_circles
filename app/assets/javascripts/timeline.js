// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery.colorbox

$( function() {
    $(document).on( 'click', '.recieptlink', function() {
	event.preventDefault()
	$.colorbox( {
	    href: $(this).attr('href'),
            onComplete: function() {
                jQuery.colorbox.resize()
            },
            height: 600,
            inline: true,
	} )
    } )
} )
