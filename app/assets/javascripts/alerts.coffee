

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
  
  # Hide the error message on click
  $('#submit_alert').on "click", ->
    $('#new_alert_error_field').hide()
    $('#target_value_group').removeClass("has-error")

  $("#new_alert").on("ajax:success", (e, data, status, xhr) ->
    console.log("ok")

    #success notice
    $('#notice_text').html("Alerte crée !")
    $('#notice_div').removeClass("alert-danger")
    $('#notice_div').addClass("alert-success")
    $('#notice_div').fadeIn(0).fadeOut(3000)
    
    
  ).on "ajax:error", (e, jqXHR, textStatus, errorThrown) ->
    console.log("pas ok")
    
    $('#new_alert_error_field').show()
    $('#target_value_group').addClass("has-error")
    data = JSON.parse( jqXHR.responseText )
    console.log(data['errors'])
    $('#new_alert_error_field').html(data['errors'])
    
    #error notice
    $('#notice_text').html("Erreur !")
    $('#notice_div').removeClass("alert-success")
    $('#notice_div').addClass("alert-danger")
    $('#notice_div').fadeIn(0).fadeOut(3000)
    
