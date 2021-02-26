class HabitsController < ApplicationController
    def new
        @habit = Habit.new
        authorize @habit
    end
    def create
        @habit = Habit.new(habit_params)
        @habit.user = current_user
        authorize @habit
        if @habit.save
            redirect_to profile_path(current_user)
        else
            render :new
        end
    end

    def update
    end

    private

    def habit_params
        params.require(:habit).permit(:avg_cig, :cost_a_pack)
    end

end
