class RacesController < ApplicationController
    def index
        @races = policy_scope(Race).order(created_at: :desc)
        authorize @races
    end

    def show
        @race = Race.find(params[:id])
        authorize @race
    end

    def new
        @race = Race.new
        authorize @race
    end

    def create
        @race = Race.new(race_params)
    end


    def destroy
        @race = Race.find(params[:id])
        @race.destroy
        if @race.destroy
            redirect_to profile_path
        else
        end
    end

    private

    def race_params
        params.require(:race).permit(:start_time, :duration, :public)
    end
end
