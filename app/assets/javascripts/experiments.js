//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/


function ExperimentEvents()
{
  $('#expAction').blur(function(){
    var actionText = $(this).val();
    var regNum = /[0-9]*/;
    var respText = actionText;

    respText = actionText.replace(' less ',' more ');
    if(respText == actionText)
    { respText = actionText.replace(' more ', ' less '); }
    if(respText == actionText)
    { respText = actionText.replace(' at least ', ' less than '); }
    if(respText == actionText)
    { respText = actionText.replace(' at most ', ' more than '); }

    if((respText == actionText) && (regNum.test(actionText)))
    {
      respText = actionText.replace(/[0-9]\S/, '0');
    }
    else if(respText==actionText)
    {
      respText = 'Not ' + actionText;
    }
    $('#expControl').val(respText);
  });
}

$(document).ready(function(){ ExperimentEvents(); });
$(document).on('page:load', function(){ ExperimentEvents(); });