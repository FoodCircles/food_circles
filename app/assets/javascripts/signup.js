var FCJS = FCJS || {}

FCJS.setHiddenCC = function (e) {
  if ($('#cc-input').hasClass('unmasked')) {
    $('#cc-hidden').val(
      bf_encrypt($('#cc-input').val())
    );
  }
};

FCJS.maskCCInput = function (e) {
  var cc = $('#cc-input').val();

  var masked = bf_mask(cc);

  if (!cc.includes('xxxx')) {
    $('#cc-input').val(masked);
    $('#cc-input').removeClass('unmasked');
  }
};

$(document).ready(function() {
  $('#cc-input').on('focusout', function(e) {
    FCJS.setHiddenCC(e);
    FCJS.maskCCInput(e);
  });
});
