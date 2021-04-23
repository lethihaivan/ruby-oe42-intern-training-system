// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require i18n/translations
//= require i18n
//= require i18n.js

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import alertify from "alertifyjs"
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
    alertify.error(I18n.t("courses.add_trainee"));
  } else {
    alertify.confirm(I18n.t("alert.confirm_text"), I18n.t("alert.confirm"),
      function(){
        $.ajax({
          url: window.location.href + '/add_trainee',
          type: 'POST',
          data: {trainee_ids: checked},
          dataType: 'json'
        })
        .done(function(el) {
          if(el && el.error){
            alertify.error(el.error);
          } else {
            alertify.success(el.success);
          }
        })
        .fail(function(err) {
          alertify.error(err);
        });
        $('#modal-trainee').modal('hide');
        $('.nav-item a[href="#pills-trainee"]').tab('show');
      },
      function(){
        alertify.error(I18n.t("courses.cancel"));
      });
  };
});

$(document).on('click', '#delete_trainee', function(e){
  var this_el = $(this);
  var trainee_id = parseInt($(this).attr('trainee_id'));
  alertify.confirm(I18n.t("alert.confirm_text"), I18n.t("alert.confirm"),
    function(){
      $.ajax({
        url: window.location.href + '/delete_trainee',
        data: {user_id: trainee_id},
        type: 'DELETE',
        dataType: 'json'
      })
      .done(function(el) {
        if(el.success){
          this_el.closest('li').slideUp().remove();
          alertify.success(el.success);
          var sum_trainees = parseInt($('#sum_trainees').html()) - 1;
          $('#sum_trainees').html(sum_trainees)
        } else {
          alertify.error(el.error);
        }
      })
      .fail(function(err) {
        alertify.error(err);
      });
    },
    function(){
      alertify.error(I18n.t("courses.cancel"));
    });
});

$(document).ready(function(){
  $(".click").click(function(){
    var target = $(this).parent().children(".expand");
    $(target).slideToggle();
  });
});
