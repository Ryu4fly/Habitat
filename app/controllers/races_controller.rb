class RacesController < ApplicationController
    def index
        @races = policy_scope(Race).order(start_time: :asc).where('start_time > ?', Time.now).limit(10)
        authorize @races
    end

    def show
        @race = Race.find(params[:id])
        @racer = user_is_racer?(@race)
        @lanes = @race.lanes
        @average_cigs = []
        @ranking = []
        @pool = race_pool(@race)
        @race.lanes.each do |lane|
          lane_sum = lane_total(lane)
          odds = lane_sum == 0 ? '10/1' : (race_pool(@race) / lane_sum).to_r
          @ranking << { user: lane.user.username, total_cigs: cigs_since_race_began(lane) }
          @average_cigs << Hash[lane.user.username, {lane_total: lane_total(lane), odds: odds}]
      end
        @ranking.sort_by! { |k| k[:total_cigs]}
        authorize @race
    end

    def new
        @race = Race.new
        @max_date = Date.today + 1.week
        authorize @race
    end

    def create
        @race = Race.new(race_params)
        @race.end_time = params[:start_time] + params[:duration]
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
        params.require(:race).permit(:start_time, :duration)
    end

    def join_race(race)
        @lane = Lane.new
        @lane.user = current_user
        @lane.race = race
        @lane.save
    end

    def cigs_since_race_began(lane)
        cig_total = 0
        relevant_entries = lane.user.entries.where('date > ? AND date < ?', lane.race.start_time, lane.race.end_time)
        relevant_entries.each do |entry|
            cig_total += entry.cig_smoked
        end
        cig_total
    end

end
