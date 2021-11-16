class EntriesController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    @entries = Entry.all
  end

  def create
    @entry = current_user.entries.build(entry_params)
    @entry.temperature = 22
    if @entry.save
      redirect_to root_path
    else
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
    params.require(:entry).permit(:city, :note)
  end
end
  