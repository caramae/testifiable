class StaticPagesController < ApplicationController
  def home
  	unless current_user.nil?
  		redirect_to user_path(current_user)
  	end
  end

  def about
  end
end
