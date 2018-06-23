module ApplicationHelper

  def authenticate_redirect
    unless user_signed_in?
        redirect_to root_path
    end
  end
end
