// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require i18n/translations
//= require alertify
//= require i18n
//= require i18n.js

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
require("jquery")
import I18n from "i18n-js/index.js.erb"
import toastr from "toastr/toastr"
import { success } from "toastr"

toastr.options = {
  "escapeHtml": true,
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "3000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}
window.I18n = I18n
Rails.start()
Turbolinks.start()
ActiveStorage.start()
global.toastr = toastr
$(document).ready(function(){
  $("#course_subject_ids").select2();
});


$(document).on('click', '#add_trainee', function(e){
  var checked = []
  $("input[name='course[trainee_ids][]']:checked").each(function ()
  {
    checked.push(parseInt($(this).val()));
  });
  if( checked.length == 0 ){
    alert(I18n.t("alert.no_choose_user"));
  } else {
    $.ajax({
      url: window.location.href + '/add_trainee',
      type: 'POST',
      data: {trainee_ids: checked},
      dataType: 'script',
      success: function(data) {
        alert(I18n.t("alert.success"));
      }
    });
    $('#modal-trainee').modal('hide');
    $('.nav-item a[href="#pills-trainee"]').tab('show');
  };
});

