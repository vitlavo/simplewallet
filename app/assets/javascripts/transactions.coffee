$ ->
  errors_block = $('#transaction-errors')
  $('#transaction-create').on('ajax:success', (event) ->
    alert(event.detail[0].message)
    location.reload()
  ).on('ajax:error', (event) ->
    errors_block.append(event.detail[0].message)
    errors_block.show()
  ).on 'ajax:beforeSend', ->
    errors_block.html('')
    errors_block.hide()
