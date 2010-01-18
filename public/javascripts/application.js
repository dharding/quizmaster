jQuery(document).ready(function(){
  var mini_search_simple = $('#mini-search .simple');
  var mini_search_advanced = $('#mini-search .advanced');
  var mini_search_toggles = $('#mini-search .simple .fr, #mini-search .advanced .fr');
  mini_search_toggles.click(function() {
    mini_search_simple.toggle();
    mini_search_advanced.toggle();
  });
});

jQuery(document).ready(function(){
  $('.file_uploader .button button').click(function() {
    return false;
  });
  
  var file_uploader_inputs = $('.file_uploader input[type="file"]');
  file_uploader_inputs.change(function() {
    var input = $(this);
    input.next('.fake_file_uploader').children('.filename').text(input.val());
  });
});

// jQuery(document).ready(function(){
//   $('#user_employed').change(function() {
//     var is_employed = $(this).val() == "true";
//     $('#user_current_job_description').closest('.form_item').toggle(is_employed);
//   });
// });