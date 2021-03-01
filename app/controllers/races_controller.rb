class RacesController < ApplicationController
    def index
        @races = policy_scope(Race).order(start_time: :asc).where('end_time > ?', Date.today)
        authorize @races
    end

    def show
        @race = Race.find(params[:id])
        @racer = user_is_racer?(@race)
        @lanes = @race.lanes
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
            redirect_to races_path
        else
            render :new
        end
    end

    def update
        @race = Race.find(params[:id])
        authorize @race
        join_race(@race) if params[:join_race]
    end

    def destroy
        @race = Race.find(params[:id])
        @race.destroy
        if @race.destroy
            redirect_to profile_path
        else
        end
    end

    def race_dashboard
        @races = Race.includes(:bets)
        @bets = current_user.bets.order(created_at: :desc)
        @my_lanes = current_user.lanes.order(created_at: :desc)
        @balance = current_user.balance
        authorize @races
    end

    private

    def race_params
        params.require(:race).permit(:start_time, :duration, :public)
    end

    def join_race(race)
        @lane = Lane.new
        @lane.user = current_user
        @lane.race = race
        @lane.save
    end

end
