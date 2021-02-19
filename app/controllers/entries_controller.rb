class EntriesController < ApplicationController
  before_action :find_entry, only: [:show, :destroy]

  def index
    @entries = policy_scope(Entry).order(created_at: :desc)
    # @entries = policy_scope(Entry)
  end

  def show
  end

  def new
    @entry = Entry.new
    authorize @entry
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user = current_user
    authorize @entry
    if @entry.save
      redirect_to entries_path
    else
      render :new
    end
  end

  def destroy
    @entry.destroy
  end

  private

  def find_entry
    @entry = Entry.find(params[:id])
    authorize @entry
  end

  def entry_params
    params.require(:entry).permit(:date, :feeling, :craving, :cig_smoked, :context)
  end
end
