window.fbAsyncInit = function() {
  FB.init({
    appId      : '539330539599875',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.8' // use graph api version 2.8
  });
};

(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
  console.log("loaded facebook js");
}(document, 'script', 'facebook-jssdk'));
 
function logout(){
  console.log("login out");
  FB.logout(function(response){
    $.ajax({
      url: '/users/sign_out',
      method: 'DELETE',
      success: function(){
        console.log("loggged out");
        window.location.replace('/');
      }
    });
  });
}

function login(){
  FB.login(function(response) {
    console.log(response);
    if (response.authResponse) {
      $('#status').html('Connected! Hitting OmniAuth callback (GET /auth/facebook/callback)...');
      $.ajax({
      url: '/auth/facebook/callback',
      success: function(){
        console.log('cool');
        window.location.replace('/');
      }
    });
    }
  }); 
}

$(document).ready( function(){
  $('a#facebook-connect').on('click', function(e) {
    e.preventDefault();
    console.log("click");
    FB.getLoginStatus(function(response) {
      console.log(response);
      if(response.status == 'connected'){
        logout();
      }else{
        login();
      }
    }); 
 });
});
