# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
###
jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$(document).ready ->
  message = document.getElementsByClassName('popup')[0]

  if message.indexOf("Successfully enrolled",0) == 0
    modal_html = """
                 <div class="modal" id="deleteModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>FFF</h4>
                   </div>
                   <div class="modal-body">
                     <p>You will not be able to see the results of this experiment without participating in it.</p>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">Ok</a>
                   </div>
                 </div>
                 """

  $modal_html = $(modal_html)
  $modal_html.modal()
  return false
  ###
  
check_strength = (password) ->
  desc = []
  desc[0] = "<i class='fa fa-times'></i> Very Weak"
  desc[1] = "<i class='fa fa-times'></i> Weak"
  desc[2] = "<i class='fa fa-times'></i> Better"
  desc[3] = "<i class='fa fa-check'></i> Medium"
  desc[4] = "Strong"
  desc[5] = "Strongest"

  score = 0
  # if password bigger than 6 give 1 point
  if password.length < 6 
    $("#strength-desc").html("<i class='fa fa-times'></i> Password must be at least 6 characters").removeClass().addClass("pw-invalid")
  else 
    # if password has both lower and uppercase characters give 1 point	
    if password.match(/[a-z]/) and password.match(/[A-Z]/)
      score++

    # if password has at least one number give 1 point
    if password.match(/\d+/)
      score++

    # if password has at least one special caracther give 1 point
    if password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)
      score++

    # if password bigger than 12 give another 1 point
    if password.length > 12
      score++
    
    if score < 2
      $("#strength-desc").html("<i class='fa fa-check'></i> Password could be stronger").removeClass().addClass("pw-valid")
    else 
      $("#strength-desc").html("<i class='fa fa-check'></i> Good password").removeClass().addClass("pw-valid")  


jQuery ->
  $('#user_password').keyup ->
    check_strength($('#user_password').val())