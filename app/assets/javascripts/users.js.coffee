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