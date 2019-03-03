class WorkoutOfTheDay::Workout
  attr_accessor :name, :description, :url, :time

  @@all = []

  def self.all
    workout_1 = self.new
    workout_1.name = "Crossfit: Saturday 190302"

    workout_2 = self.new
    workout_2.name = "Rowing: 5000m with rate changes"

    workout_3 = self.new
    workout_3.name = "Military: SOF WOD MAR 1"

    workout_4 = self.new
    workout_4.name = "No Equipment, No Running Bodyweight WODs"

    [workout_1, workout_2, workout_3, workout_4]
  end



end
