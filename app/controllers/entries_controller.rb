class EntriesController < ApplicationController
  before_action :find_entry, only: [:show, :destroy]

  def index
    @entries = policy_scope(Entry).order(date: :desc)
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

    redirect_to entries_path
  end

  def my_stats
    @cig_entries = Entry.where('cig_smoked > 0')
    @date_cigs = reduce_same_date_entries(@cig_entries)
    
    authorize @cig_entries
  end

  private

  def find_entry
    @entry = Entry.find(params[:id])
    authorize @entry
  end

  def entry_params
    params.require(:entry).permit(:date, :feeling, :craving, :cig_smoked, :context)
  end

  def reduce_same_date_entries(entries)
    date_cig = []
    entries.each do |entry|
      dates = date_cig.map { |obj| obj[:date] }
      if date_cig.empty? || !dates.include?(entry.date.to_s)
        cig_entry = {
          date: entry.date.to_s,
          cig_smoked: entry.cig_smoked
        }
        date_cig << cig_entry
      else
        existing_date = date_cig.select { |obj| obj[:date] == entry.date.to_s }
        existing_date[0][:cig_smoked] += entry.cig_smoked
      end
    end
    date_cig
  end
end
