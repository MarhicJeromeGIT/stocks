$ ->
  url = window.location.href.substr(window.location.href.lastIndexOf('/') + 1);
  #console.log(url);
  
  $('.navbar-nav li').each (index, element) ->
    href = $(element).find('a').attr('href');
    # get the last part of the url.
    href = href.substr(href.lastIndexOf('/') + 1);
    #console.log('href: '+href);
    if href == url 
      $(element).addClass('active')
