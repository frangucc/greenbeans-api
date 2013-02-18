// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery-ui
//= require_tree .
//= require merchant/timepicker
//= require bootstrap-alert

function new_prize()
{
    $(".bg-inner").load("new_prize");
}

function create_prize()
{
    //alert("ok");

    //
    //alert($('#selected_option').val());
   if($('#selected_option').val()==1){

       //alert("ok");
   $(".bg-inner").load("create_prize");
   }
   else if($('#selected_option').val()==2){
      $(".bg-inner").html("create_prize");
   }
   else{
      $(".bg-inner").html("select options");
   }
}
function create_input_fields(){
 $('.prize_field').html("");
    for(var i = 0; i <$('#no_of_winners').val() ; i++)
{
    var this_box = $('<input type="text" name="tire_prize' + i + '" class="money"  />  <input type="text" name="tire_name' + i + '" placeholder="'+(i+1)+'st Prize" disabled=true/><br/>');
    $('.prize_field').append(this_box);
}
}