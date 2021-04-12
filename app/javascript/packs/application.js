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
        window.location.reload()
      }
    });
    $('#modal-trainee').modal('hide');
    $('.nav-item a[href="#pills-trainee"]').tab('show');
  };
});
$(document).on('click', '#delete_trainee', function(e){
  var trainee_id = parseInt($(this).attr('trainee_id'));
    $.ajax({
      url: window.location.href + '/delete_trainee',
      data: {user_id: trainee_id},
      type: 'DELETE',
      dataType: 'script',
      success: function(data) {
        alert(I18n.t("alert.delete_success"));
        window.location.reload()
      }
    })
});
$(document).on("turbolinks:load", function(){
  $('[id^=subject-]').hide();
  $('[id^=menu_show-]').hide();
  $("#course_subjects").chosen();
  $("#suppervisor_course, #suppervisor_subject").chosen({
  disable_search_threshold: I18n.t("disable_search_threshold"),
  allow_single_deselect: true,
  no_results_text: I18n.t("not_found")
});
if($('.nested_form_tasks').length > 0) {
  nestedForm = $('.nested_form_tasks').last().clone();
}

if($('textarea').length > 0) {
  $('textarea').each (function(){
    Id = $(this).attr('id');
    new SimpleMDE({ element: document.getElementById(Id) });
  });
};
})(jQuery);

$(document).on('click', '.toggle_subject, .toggle_menu', function(e){
$input = $( this );
$target = $('#'+$input.attr('data-toggle'));
$target.slideToggle();
});

$(document).on('click', '.duplicate_nested_form', function(e){
e.preventDefault();
lastNestedForm = $('.nested_form_tasks').last();
newNestedForm  = $(nestedForm).clone();
formsOnPage    = $('.nested_form_tasks').length;
$(newNestedForm).find('input, textarea').each (function(e){
  oldId = $(this).attr('id');
  $(this).val('');
  $(this).parent().find('.number').text(formsOnPage + 1);
  $('#number_sum').html(formsOnPage + 1);
  newId = oldId.replace(new RegExp(/_[0-9]+_/), '_'+formsOnPage+'_');
  $(this).attr('id', newId);
  oldName = $(this).attr('name');
  newName = oldName.replace(new RegExp(/\[[0-9]+\]/), '['+formsOnPage+']');
  $(this).attr('name', newName);
  $(newId).hide();
});
$( newNestedForm ).insertAfter( lastNestedForm);
new SimpleMDE({ element: document.getElementById(newId)});
});

$(document).on('click', '.destroy_nested_form_tasks', function(e){
e.preventDefault();
if( $('.nested_form_tasks').length > $('.task_delete').length + 1) {
  $(this).closest('.nested_form_tasks').find('input:hidden').val(1);
  alertify.warning(I18n.t('subjects.task.confirm_save'));
  $(this).closest('.nested_form_tasks').addClass("task_delete");
} else {
  alert("Not access")
}
});
