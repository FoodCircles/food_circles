// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery.colorbox
//= require home

$(function () {
    $("body").on("submit", "#send_text_form", function (event) {
        $("#send_text_arrow").hide();
        $("#send_text_loader").show();
    });
});