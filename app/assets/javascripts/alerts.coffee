

$ ->
  ###
  $('#submit_alert').on "click", ->
    stock_id = $('#alert_stock_id').val()
    target_value = $('#alert_target_value').val()
    
    $.ajax
      url: '/alerts'
      type: 'POST'
      data: {alert: {stock_id: stock_id, target_value: target_value}}
      dataType: 'application/json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("error" + jqXHR)
      success: (data, textStatus, jqXHR) ->
        console.log("success" + data)
  ###
  
  
  $("#new_alert").on("ajax:success", (e, data, status, xhr) ->
    console.log("ok")
  ).on "ajax:error", (e, jqXHR, textStatus, errorThrown) ->
    console.log("pas ok")
    data = JSON.parse( jqXHR.responseText );
    console.log(data['errors'])
    $('#new_alert_error_field').html(data['errors'])