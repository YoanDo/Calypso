STATUS = ["pending", "going", "cancelled"]
CATEGORY = ["Surf", "Kitesurf", "Windsurf"]

class Trip < ApplicationRecord
  belongs_to :user
  has_one :to, -> { where direction: "to"}, class_name: "Location", :dependent => :destroy
  has_one :from, -> { where direction: "from"}, class_name: "Location", :dependent => :destroy

  has_many :participants, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  accepts_nested_attributes_for :to, :from

  validates :title, presence: :true, uniqueness: true
  # validates :from, presence: :true
  # validates :to, presence: :true
  validates :starts_at, presence: :true
  validates :ends_at, presence: :true
  validates :description, presence: :true
  validates :nb_participant, presence: :true
  validates :status, inclusion: { in: STATUS }
  validates :category, inclusion: { in: CATEGORY }

  before_save :calcul_itinary, on: [ :update ]

  def is_full?
    self.participants.where(status: "accepted").count >= self.nb_participant
  end

  def pending_to_waiting_list
    self.participants.where(status: "pending").each { |participant| participant.waiting_list }
  end

  def has_participant(user)
    self.participants.each do |participant|
      if participant.user == user
        return { participant: participant, status: participant.status }
      end
    end
    return { participant: nil, status: false }
  end

  def calcul_itinary
    if self.from.present?
      response = open("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{from.address}&destinations=#{to.address}&key=#{ENV['GOOGLE_API_SERVER_KEY']}").read
      response = JSON.parse(response)
      unless response["rows"][0]["elements"][0]["duration"].nil?
        self.estimated_duration = response["rows"][0]["elements"][0]["duration"]["value"]
      end
    end
  end

  def light_weather
    response = open("https://api.worldweatheronline.com/premium/v1/marine.ashx?key=#{ENV['WWO_KEY']}&format=json&q=#{to.latitude},#{to.longitude}").read
    response = JSON.parse(response)
    date = self.starts_at.strftime("%Y-%m-%d")
    light_weather = {}
    response["data"]["weather"].each do |w|
      if w["date"] == date
        light_weather[:wave] = w["hourly"][5]["sigHeight_m"]
        light_weather[:periode] = w["hourly"][5]["swellPeriod_secs"]
        light_weather[:sweel] = w["hourly"][5]["swellHeight_m"]
        light_weather[:sweel_direction] = w["hourly"][5]["swellDir16Point"]
        light_weather[:wind_speed] = w["hourly"][5]["windspeedKmph"]
        light_weather[:wind_direction] = w["hourly"][5]["winddir16Point"]
      end
    end
    return light_weather
  end

  def weather
    response = open("https://api.worldweatheronline.com/premium/v1/marine.ashx?key=#{ENV['WWO_KEY']}&format=json&q=#{to.latitude},#{to.longitude}").read
    response = JSON.parse(response)
    date = self.starts_at.strftime("%Y-%m-%d")
    forecast_time = []
    forecast_wave = []
    response["data"]["weather"].each do |w|
      if w["date"] >= date
        date_forecast = Date.parse w["date"]
        w["hourly"].each do |h|
          hour_forecast = transform_hour(h["time"])
          forecast_time << "#{date_forecast.strftime("%a")} #{hour_forecast}"
          forecast_wave << h["sigHeight_m"]
        end
      end
    end
    return [ light_weather, forecast_time, forecast_wave]
  end

  def transform_hour(hours)
    if hours.size == 1
      hours = "#{hours}h"
    elsif hours.size == 3
      hours = "#{hours.first}h"
    else
      hours = "#{hours.first(2)}h"
    end
  end
end
