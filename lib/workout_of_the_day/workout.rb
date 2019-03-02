class WorkoutOfTheDay::Workout

  @@all = []

  def self.all
    @@all << self
    puts <<-DOC
      1. Crossfit: Saturday 190302
      2. Rowing: 5000m with rate changes every 1000m: 22-26-22-26-22 r#andomly choose 1 of 3
      3. Military: SOF WOD MAR 1
      4. No Equipment, No Running Bodyweight WODs
    DOC
  end

end
