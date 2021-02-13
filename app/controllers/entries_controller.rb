class EntriesController < ApplicationController

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
    def delete
    end

    private

    def entry_params
        params.require(:entry).permit(:craving, :feeling)
    end
end
