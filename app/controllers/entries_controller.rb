class EntriesController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    @entries = Entry.all
  end

  def create
    entry = EntryCreator.call(entry_params, current_user)
    if entry.created?
      flash[:notice] = 'New entry added'
      redirect_to root_path
    else
      flash[:alert] = entry.payload.errors.full_messages
      redirect_to root_path
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to @entry
    else
      render :edit
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:location, :note)
  end
end
  