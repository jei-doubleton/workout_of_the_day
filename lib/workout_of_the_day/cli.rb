class WorkoutOfTheDay::CLI
  attr_reader :workout_input

  def call
      list_workouts
      workout_menu
      goodbye
  end

  def list_workouts
    puts "Today's Daily Workouts:"
    @deals = WorkoutOfTheDay::Workout.all
  end

  def workout_menu_instructions
    puts "Enter the number of the workout you'd like details on, type list to see the workouts again, or type exit to leave the program."
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
      elsif @workout_input == "list"
        list_workouts
      elsif @workout_input != "exit"
        invalid_input
      end
      more_workouts?
    end
  end

  def more_workouts?
    puts "Would you like to see another workout? (y/n)"
    input = gets.strip.downcase
    if input == "y"
      workout_menu
    elsif input == "n"
      @workout_input = "exit"
    else
      invalid_input
    end
  end

  def goodbye
    puts "See you tomorrow for your next workout!"
  end

end
