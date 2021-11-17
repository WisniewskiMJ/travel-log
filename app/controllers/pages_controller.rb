class PagesController < ApplicationController
  def welcome
  if user_signed_in?
    redirect_to entries_url
  end
end
end