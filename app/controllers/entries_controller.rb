class EntriesController < ApplicationController

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  private

  def entries_params
    params.require(:review).permit(:date, :craving, :feeling, :user_id)
  end
end
