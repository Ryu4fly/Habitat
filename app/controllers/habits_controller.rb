class HabitsController < ApplicationController
    def new
        @habit = Habit.new
        authorize @habit
    end
    def create
        @habit = Habit.new
    end
end
