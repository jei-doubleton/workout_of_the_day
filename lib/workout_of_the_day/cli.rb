class WorkoutOfTheDay::CLI
  attr_reader :workout_input, :workout

  @@green = "\e[32m"
  @@blue = "\e[34m"
  @@gray = "\e[37m"
  @@gray_bkgd = "\e[47m"
  @@black = "\e[30m"
  @@default = "\e[39m"
  @@default_bkgd = "\e[49m"

  def call
    @workout_input = nil

    load_workouts
    list_workouts

    while @workout_input != "exit"
      workout_menu
      more_workouts?
    end
    goodbye
  end

  def load_workouts
    puts "Welcome to your daily workout! Your workout options are now loading..."
    WorkoutOfTheDay::Scraper.new
  end

  def list_workouts
    puts "Today's Daily Workouts:"
    puts ""
    @workout = WorkoutOfTheDay::Workout.all

    @workout.each.with_index(1) do |w, i|
      puts "#{@@blue}#{i}. #{w.name}"
    end
    puts "#{@@default}"
  end

  def workout_menu_instructions
    puts "Enter the number of the workout you'd like to see #{@@green}(1-#{@workout.length})#{@@default}, type #{@@green}list#{@@default} to see the workouts again, or type #{@@green}exit#{@@default} to leave the program."
  end

  def invalid_input
    puts "Whoops! That wasn't one of the choices. Please enter a different input:"
  end

  def workout_menu
    workout_menu_instructions

    input = gets.strip.downcase
    chosen_workout = @workout[input.to_i - 1]

    if input.to_i > 0
      puts ""
      puts "#{@@gray_bkgd}#{@@black}-------#{chosen_workout.name}-------#{@@default_bkgd}"
      puts "#{@@green}#{chosen_workout.description}"
      puts ""
      puts "#{@@default_bkgd}#{@@gray}Source: #{@@blue}#{chosen_workout.url}#{@@default}"
      puts ""
    elsif input == "list"
      list_workouts
    elsif input == "exit"
      @workout_input = "exit"
    else
      invalid_input
      workout_menu_instructions
    end
  end

  def more_workouts?
    while @workout_input != "exit"
      puts "Would you like to see another workout? (y/n)"
      input = gets.strip.downcase
      if input == "y"
        workout_menu
        more_workouts?
      elsif input == "n"
        @workout_input = "exit"
      else
        invalid_input
        more_workouts?
      end
    end
  end

  def goodbye
    puts "See you tomorrow for your next workout!"
  end

end
