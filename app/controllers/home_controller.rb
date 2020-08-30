class HomeController < ApplicationController
  def index
    if not collaborator_signed_in?
      redirect_to new_collaborator_session_path
    end
  end
end
