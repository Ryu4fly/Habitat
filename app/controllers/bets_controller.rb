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
      @pool = race_pool(@race)
      @user = current_user
      @race.lanes.each do |lane|
        lane_sum = lane_total(lane)
        odds = lane_sum == 0 ? '10/1' : (race_pool(@race) / lane_sum).to_r
        @average_cigs << Hash[lane.user.username, {avg_cig: avg_cig(lane.user), odds: odds}]
      end
      authorize @bet
    end

    def create
      @bet = Bet.new(bet_params)
      @bet.user = current_user
      authorize @bet

      if @bet.save
        current_user.update(balance: @bet.user.balance - @bet.amount)
        redirect_to race_dashboard_path
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

    def claim_bets
      @bets = Bet.where('user_id = ? AND winnings_have_been_collected = ?', current_user.id, false)
      @balance = current_user.balance
      authorize @bets
      @unclaimed_winnings = []
      @bets.each do |bet|
          @unclaimed_winnings << bet if bet.race.end_time < Time.now
      end
    end

    private

    def bet_params
        params.require(:bet).permit(:amount, :lane_id)
    end

end
