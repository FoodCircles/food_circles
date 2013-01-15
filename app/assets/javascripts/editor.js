// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var h,d=false,o;
$(function() {
    $(document).on('mousedown', function() {
	o = $('<div class="calObj"></div>');
	o.appendTo($('#ec'));	
	o.css({'top': h.offset().top,'left':h.offset().left});
	d=true;
    });
    $(document).on('mouseup',function() {
	d = false;
    });
    $('td').hover(function() {
	h = $(this);
	if (d) {
	    o.height(h.offset().top - o.offset().top);
	}
    });
});