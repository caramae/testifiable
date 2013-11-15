//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/


function ExperimentEvents()
{
  $('#expAction').blur(function(){
    actionText = $(this).val();
    $('#expControl').val('Not ' + actionText);
  })
}

$(document).ready(function(){ ExperimentEvents(); });
$(document).on('page:load', function(){ ExperimentEvents(); });