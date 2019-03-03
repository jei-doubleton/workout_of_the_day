class WorkoutOfTheDay::CLI
  attr_reader :workout_input, :workout

  def call
    load_workouts
    list_workouts
    workout_menu
    goodbye
  end

  def load_workouts
    puts "Welcome to your daily workout! Your workout options are now loading."
    WorkoutOfTheDay::Scraper.new
  end

  def list_workouts
    puts "Today's Daily Workouts:"
    @workout = WorkoutOfTheDay::Workout.all

    @workout.each.with_index(1) do |w, i|
      puts "#{i}. #{w.name}"
    end
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
      if @workout_input.to_i > 0
        puts @workout[@workout_input.to_i - 1].description
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
