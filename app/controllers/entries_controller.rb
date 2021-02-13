class EntriesController < ApplicationController
  def index
    @entries = Entry.available
  end

  def show
    @entry = Entry.find(entry_param)
  end

  private

  def entry_params
    params.require(:entry).permit(:date, :feeling, :craving, :user_id)
  end
end
