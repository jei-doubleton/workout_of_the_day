class WorkoutOfTheDay::Workout
  attr_accessor :name
  @@all = []

  def self.all
    # @@all << self
    # puts <<-DOC
    #   1. Crossfit: Saturday 190302
    #   2. Rowing: 5000m with rate changes every 1000m: 22-26-22-26-22 r#andomly choose 1 of 3
    #   3. Military: SOF WOD MAR 1
    #   4. No Equipment, No Running Bodyweight WODs
    # DOC

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
