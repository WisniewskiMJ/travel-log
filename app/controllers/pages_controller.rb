class PagesController < ApplicationController
  def welcome
    redirect_to entries_url if user_signed_in?
  end
end