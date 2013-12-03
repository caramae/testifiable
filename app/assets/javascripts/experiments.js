//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/


function ExperimentEvents()
{
  $('#expAction').blur(function(){
    var actionText = $(this).val();
    var reg = /[0-9]*/;
    var respText = actionText;
    if(reg.test(actionText))
    {
      respText = actionText.replace(/[0-9]\S/, '0');
    }
    else
    {
      respText = 'Not ' + actionText;
    }
    $('#expControl').val(respText);
  });
}

$(document).ready(function(){ ExperimentEvents(); });
$(document).on('page:load', function(){ ExperimentEvents(); });