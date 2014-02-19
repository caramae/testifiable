jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$.rails.allowAction = (element) ->
  # The message is something like "Are you sure?"
  message = element.data('confirm')
  # If there's no message, there's no data-confirm attribute, which means there's nothing to confirm
  return true unless message

  if message.indexOf("Delete",0) == 0
    # Clone the clicked element so we can use it in the dialog box.
    $link = element.clone()
      # We don't necessarily want the same styling as the original link/button.
      .removeAttr('class')
      # We don't want to pop up another confirmation (recursion)
      .removeAttr('data-confirm').addClass('btn btn-danger whiteText').html("Yes, I'm certain.")

    message = message.slice(7)

    # Create the modal box with the message
    modal_html = """
                 <div class="modal" id="deleteModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>Are you sure you want to delete this #{message}?</h4>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">Cancel</a>
                   </div>
                 </div>
                 """

  else if message.indexOf("Prereqs",0) == 0
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn btn-primary whiteText').html("Conditions met: Enroll me!")
    message = message.slice(8)

    modal_html = """
                 <div class="modal" id="prereqModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>You must meet the following conditions to enroll:</h4>
                   </div>
                   <div class="modal-body">
                     <p>#{message}</p>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">Conditions not met</a>
                   </div>
                 </div>
                 """

  else if message.indexOf("AssignedAction",0) == 0
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn btn-primary whiteText').html("Ok")
    message = message.slice(15)

    modal_html = """
                 <div class="modal" id="prereqModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>Successfully enrolled in experiment.</h4>
                   </div>
                   <div class="modal-body">
                     <p>Your assigned action is: #{message}</p>
                   </div>
                   <div class="modal-footer">
                   </div>
                 </div>
                 """

  else if message.indexOf("InitAssignedAction",0) == 0
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn btn-primary whiteText').html("Ok")
    message = message.slice(15)

    modal_html = """
                 <div class="modal" id="prereqModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>Successfully enrolled in experiment.</h4>
                   </div>
                   <div class="modal-body">
                     <p>You must record initial values before being assigned an action.</p>
                   </div>
                   <div class="modal-footer"><!--a data-dismiss="modal" class="btn">Enter initial value later</a-->
                   </div>
                 </div>
                 """

  else if message.indexOf("Reenroll?",0) == 0
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn btn-primary whiteText').html("Yes")
    message = message.slice(15)

    modal_html = """
                 <div class="modal" id="prereqModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>Successfully entered datapoint.</h4>
                   </div>
                   <div class="modal-body">
                     <p>Would you like to reenroll in this experiment?</p>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">No</a>
                   </div>
                 </div>
                 """

  else if message.indexOf("Unenroll",0) == 0
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn btn-danger whiteText').html("Yes, unenroll me")

    modal_html = """
                 <div class="modal" id="deleteModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h4>Are you sure you want to unenroll?</h4>
                   </div>
                   <div class="modal-body">
                     <p>You will not be able to see the results of this experiment without participating in it.</p>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">Cancel</a>
                   </div>
                 </div>
                 """

  else
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn').addClass('btn-danger').html("Unexpected.")

    # Create the modal box with the message
    modal_html = """
                 <div class="modal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h3></h3>
                   </div>
                   <div class="modal-body">
                     <p>#{message}</p>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">TKTK</a>
                   </div>
                 </div>
                 """

  $modal_html = $(modal_html)
  $modal_html.find('.modal-footer').append($link)
  $modal_html.modal()
  return false