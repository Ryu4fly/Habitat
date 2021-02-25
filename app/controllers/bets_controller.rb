class BetsController < ApplicationController
    def index
        @bets = policy_scope(Bet).order(created_at: :desc)
    end

    def show
        @bet = Bet.find(params[:id])
    end

    def new
      @bet = Bet.new
      authorize @bet
    end

    def create
      @bet = Bet.find(bet_params)

      if @bet.save
        #redirect somewhere
      else
        #render something
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
        params.require(:bet).permit(:amount)
    end
end
