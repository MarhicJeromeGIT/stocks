module OmniauthHelper
  def facebook_button
    if current_user 
      link_to 'Logout', '#', id: 'facebook-connect', class: 'btn btn-default'
    else
      link_to 'Login With Facebook', '#', id: 'facebook-connect', class: 'btn btn-default'
    end
  end

  def github_button
    if current_user 
      link_to 'Logout', '#', id: 'github-connect', disabled: true, class: 'btn btn-default'
    else
      link_to 'Login With Github', '#', id: 'github-connect', disabled: true, class: 'btn btn-default'
    end
  end
end
