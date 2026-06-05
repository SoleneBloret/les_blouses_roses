class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    unless current_user
      redirect_to new_user_session_path
    end
  end
end
