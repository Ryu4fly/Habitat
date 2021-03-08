class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  MONTHS = [nil, 'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']

  def after_sign_in_path_for(resource)
    profile_path
  end

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end
  helper_method :name_race
  helper_method :short_name
  helper_method :race_ongoing?
  helper_method :race_finished?
  helper_method :race_not_started?
  helper_method :user_is_racer?
  helper_method :user_has_bets_on_race?
  helper_method :race_full?
  helper_method :race_odds
  helper_method :avg_cig
  helper_method :lane_total
  helper_method :race_pool
  helper_method :reduce_same_date_entries

  def name_race(race)
      race_name = ''
      race.users.each_with_index do |user, index|
        race_name << user.username
        race_name << ' vs. ' if index < race.users.length - 1
      end
    return race_name
  end

  def short_name(race)
    "#{MONTHS[race.start_time.month]} #{race.start_time.day} - #{MONTHS[race.end_time.month]} #{race.end_time.day}"
  end

  def race_not_started?(race)
    return true if Time.now < race.start_time
  end

  def race_ongoing?(race)
    return true if Time.now <= race.end_time && Time.now >= race.start_time
  end

  def race_finished?(race)
    return true if Time.now > race.end_time
  end

  def user_is_racer?(race)
    race.lanes.each do |lane|
      return true if lane.user == current_user
    end
    return false
  end

  def user_has_bets_on_race?(race)
    race.bets.each do |bet|
      return bet if bet.user == current_user
    end
    return false
  end

  def race_full?(race)
      return true if race.lanes.length > 5
  end

  def avg_cig(user)
    entries = user.entries.all.order(date: :asc)
    first_date = entries.first.date
    cigs_since_joining = 0
    user.entries.each do |entry|
      cigs_since_joining += entry.cig_smoked
    end
    (cigs_since_joining.to_f / (Date.today - first_date).to_f).round(1)
  end

  def race_pool(race)
      pool = 0
      race.bets.each do |bet|
        pool += bet.amount
      end
      pool
  end

  def lane_total(lane)
      total = 0
      lane.bets.each do |bet|
        total += bet.amount
      end
      total
  end

  def reduce_same_date_entries(entries)
    date_cig = []
    entries.each do |entry|
      dates = date_cig.map { |ary| ary[0] }
      if date_cig.empty? || !dates.include?(entry.date.to_s)
        cig_entry = [
          entry.date.to_s,
          entry.cig_smoked
        ]
        date_cig << cig_entry
      else
        existing_date = date_cig.select { |ary| ary[0] == entry.date.to_s }
        existing_date[0][1] += entry.cig_smoked
      end
    end
    date_cig
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avg_cig, :cost_a_pack])
  end
end
