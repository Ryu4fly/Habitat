class BetsController < ApplicationController
    def index
        @bets = policy_scope(Bet).order(created_at: :desc).where(user: current_user)
    end

    def show
        @bet = Bet.find(params[:id])
    end

    def new
      @bet = Bet.new
      @race = Race.find(params[:race_id])
      @average_cigs = []
      @race.lanes.each do |lane|
        @average_cigs << Hash[lane.user.username, {avg_cig: avg_cig(lane.user), odds: nil}]
      end
      total = 0
      @average_cigs.each do |user|
        user.each do |elem|
          total += user[elem[0]][:avg_cig]
        end
      end
      @average_cigs.each do |user|
        user.each do |elem|
          user[elem[0]][:odds] = (total / user[elem[0]][:avg_cig]).to_r.rationalize
        end
      end
      puts "❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️❣️"
      p @average_cigs
      authorize @bet
    end

    def create
      @bet = Bet.new(bet_params)
      @bet.user = current_user
      authorize @bet

      if @bet.save
        redirect_to race_bets_path
      else
        render :new
      end
    end

    def edit
      @bet = Bet.find(params[:id])
    end

    def update
        @bet = Bet.find(bet_params)
    end

    def destroy
        @bet = Bet.find(bet_params)
        if @bet.destroy
        # redirect to somewhere
        else
        # render something
        end
    end

    private

    def bet_params
        params.require(:bet).permit(:amount, :lane_id)
    end
end
