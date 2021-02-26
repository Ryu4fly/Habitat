class RacesController < ApplicationController
    def index
        @races = policy_scope(Race).order(start_time: :asc).where('end_time > ?', Date.today)
        authorize @races
    end

    def show
        @race = Race.find(params[:id])
        authorize @race
    end

    def new
        @race = Race.new
        @max_date = Date.today + 1.week
        authorize @race
    end

    def create
        @race = Race.new(race_params)
        authorize @race
        if @race.save
            puts "*****************Successfully saved new race!"
            redirect_to races_path
        else
            render :new
        end
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
