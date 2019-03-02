class WorkoutOfTheDay::CLI
  attr_reader :workout_input, :more_workouts_input

  def call
      list_workouts
      workout_menu
      goodbye
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

  def workout_menu_instructions
    puts "Enter the number of the workout you'd like details on or enter 'exit' to exit the program."
  end

  def invalid_input
    puts "Invalid input."
    workout_menu_instructions
  end

  def workout_menu
    workout_menu_instructions
    @workout_input = gets.strip.downcase
    while @workout_input != "exit"
      if @workout_input == "1"
        puts "Crossfit workout"
      elsif @workout_input == "2"
        puts "Rowing workout"
      elsif @workout_input == "3"
        puts "military workout"
      elsif @workout_input == "4"
        puts "bodyweight workout"
      elsif @workout_input != "exit"
        invalid_input
      end
      more_workouts?
    end
  end

  def more_workouts?
    puts "Would you like to see another workout? (y/n)"
    @more_workouts_input = gets.strip.downcase
    if @more_workouts_input == "y"
      workout_menu
    elsif @more_workouts_input == "n"
      @workout_input = "exit"
    else
      invalid_input
    end
  end

  def goodbye
    puts "See you tomorrow for your next workout!"
  end

end
