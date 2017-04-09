
 
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
