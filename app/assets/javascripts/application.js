// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require highcharts/highcharts
//= require highcharts/highcharts-more

function SignInPopup() {
	$("li.signin").click(function(e) {
    e.preventDefault();
    $(this).toggleClass("menu-open");
    $("fieldset#signin_menu").toggle();
	});

	$("fieldset#signin_menu").mouseup(function() {
	    return false
	});
	$(document).mouseup(function(e) {
    if(!$(e.target).hasClass("signin")) {
      $(".signin").removeClass("menu-open");
      $("fieldset#signin_menu").hide();
    }
	});
}
/* Failure notification!
$(document).ready ->
  $("#new_post").on("ajax:success", (e, data, status, xhr) ->
    $("#new_post").append xhr.responseText
  ).bind "ajax:error", (e, xhr, status, error) ->
    $("#new_post").append "<p>ERROR</p>"
*/
function RecordDataPopup() {
	/*eventually move this to users.js.coffee*/
	$(".recorddata").click(function(e) {
    e.preventDefault();
    $(this).toggleClass("menu-open");
    $(this).next("fieldset.recorddata_menu").toggle();
	});

	$("fieldset.recorddata_menu").mouseup(function() {
    return false
	});
	$(document).mouseup(function(e) {
    $(".recorddata").removeClass("menu-open");
    $("fieldset.recorddata_menu").hide();
	});
}

function PrereqsPopup() {
  /*eventually move this to users.js.coffee*/
  $(".prereqs").click(function(e) {
    e.preventDefault();
    $(this).toggleClass("menu-open");
    $(this).next("fieldset.prereqs_menu").toggle();
  });

  $("#prereqs_cancelbutton").click(function(e) {
    e.preventDefault();
    $(".prereqs").removeClass("menu-open");
    $("fieldset.prereqs_menu").hide();
  });
  $("fieldset.prereqs_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    $(".prereqs").removeClass("menu-open");
    $("fieldset.prereqs_menu").hide();
  });
}

function ModalDialog() {
	/*eventually move this to users.js.coffee*/
	if ($('.popup').length > 0 && $('.popup').is(":visible")) {
    var back = document.createElement('div');
	  back.setAttribute('class', 'modal-backdrop');
	  document.body.appendChild(back);
	  var elem = document.getElementsByClassName('popup')[0];
	  back.appendChild(elem);
	}

	$('.modal-backdrop').click(function() {
		$('.modal-backdrop').hide();
		$('.popup').hide();
	});
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").value = "1";
  $(link).closest(".fields").hide();
}

function change_type(link) {
  $(link).parent().prev(".input-prepend").toggle();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function(){ SignInPopup(); RecordDataPopup(); PrereqsPopup(); ModalDialog(); });
$(document).on('page:load', function(){ SignInPopup(); RecordDataPopup(); PrereqsPopup(); });