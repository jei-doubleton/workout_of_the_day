class WorkoutOfTheDay::CLI
  attr_reader :input

  def call
    while @input != "Exit"
      list_workouts
      workout_menu
    end
  end

  def list_workouts
    puts "Today's Daily Workouts:"
    puts <<-DOC
      1. Crossfit: Saturday 190302
      2. Rowing: 5000m with rate changes every 1000m: 22-26-22-26-22 r#andomly choose 1 of 3
      3. Military: SOF WOD MAR 1
      4. No Equipment, No Running Bodyweight WODs
    DOC
  end

  def workout_menu
    puts "Enter the number of the workout you'd like details on or enter 'Exit' to exit the program."
    @input = gets.strip
    case @input
    when "1"
      puts "Crossfit workout"
    when "2"
      puts "Rowing workout"
    when "3"
      puts "military workout"
    when "4"
      puts "bodyweight workout"
    end
  end

end
