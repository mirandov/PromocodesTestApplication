@delete_one_ru = (link)->
  if confirm("Вы уверены?")
    link.parent().find("input[type=hidden].remove_fields").first().val("1")
    link.parent().parent().parent().parent().hide()
@del_all_rus = ->
  $('a.remove_role').on 'click', ->
    window.delete_one_ru($(this))
    false
  false

@add_new_ru = ->
  $('#add_role_link').on 'click', ->

    new_id = new Date().getTime()
    regexp = new RegExp("new_role", "g")
    content = $(this).attr('data-content')
    content = content.replace(regexp, new_id)
    $(this).parent().parent().after(content)
    panel = $(this).parent().parent().parent().find('.panel-info').first()
    panel.find('a.remove_role').on 'click', ->
      window.delete_one_ru($(this))
      false
    false
ru_ready = ->
  window.add_new_ru()
  window.del_all_rus()
$(document).on 'page:load', ru_ready
$(document).ready ru_ready
