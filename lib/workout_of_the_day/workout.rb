class WorkoutOfTheDay::Workout
  attr_accessor :name, :description, :url, :time

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end



end
