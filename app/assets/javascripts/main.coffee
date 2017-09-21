loader_f = ->
  $('.long, .longpaginate .page a, .longpaginate .next a, .longpaginate .prev a, .longpaginate .last a, .longpaginate .first a').on 'click', ->
    $('#loader').modal('show')
    true
  true
@datepicker_activation = ->
  window.datepicker_activation_by_item($(document))
@datepicker_activation_by_item = (item)->
  item.find('.datepicker').datetimepicker({locale: 'ru', format: 'DD.MM.YYYY'})  
app_ready_f = ->
  loader_f()
  window.datepicker_activation()
$(document).ready app_ready_f
$(document).on 'page:load', app_ready_f
 