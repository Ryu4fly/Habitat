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
