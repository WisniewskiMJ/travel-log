class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries
  end

  def create
    entry = EntryCreator.call(entry_params, current_user)
    if entry.created?
      flash[:notice] = "New entry added"
    else
      flash[:alert] = entry.payload.errors.full_messages
    end
    redirect_to root_path
  end

  def show
    @entry = Entry.find_by(id: params[:id])
  end

  def edit
    @entry = Entry.find_by(id: params[:id])
  end

  def update
    @entry = Entry.find_by(id: params[:id])
    if @entry.update(entry_params)
      flash[:notice] = "Entry updated"
      redirect_to @entry
    else
      flash[:alert] = @entry.errors.full_messages
      render :edit
    end
  end

  def destroy
    @entry = Entry.find_by(id: params[:id])
    @entry.destroy
    flash[:notice] = "Entry deleted"
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:location, :note, :photo)
  end
end
