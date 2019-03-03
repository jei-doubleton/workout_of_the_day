class WorkoutOfTheDay::Workout
  attr_reader :name, :description, :url

  @@all = []

  def initialize(name:, description:, url:)
    @name = name
    @description = description
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

end
