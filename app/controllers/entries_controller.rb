class EntriesController < ApplicationController
    def index
      @entries = Entry.available
    end

    def show
      @entry = Entry.find(entry_param)
    end

    def new
        @entry = Entry.new
    end
    def create
        @entry = Entry.new(entry_params)

        if @entry.save
            redirect_to root_path
        else
            redirect_to :new
        end
    end
    def destroy
        @entry = Entry.find(params[:entry_id])
        @entry.destroy
    end

    private

    def entry_params
        params.require(:entry).permit(:date, :feeling, :craving, :user_id)
    end
end
