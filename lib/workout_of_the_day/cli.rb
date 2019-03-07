class WorkoutOfTheDay::CLI

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
    puts ""
    puts "Today's Daily Workouts:"
    puts ""

    @workouts = WorkoutOfTheDay::Workout.all

    sorted_workouts = @workouts.sort do |a, b|
      a.name <=> b.name
    end

    sorted_workouts.each.with_index(1) do |w, i|
      puts "#{@@green}#{i}. #{w.name}"
    end

    puts "#{@@default}"
  end

  def workout_menu_instructions
    puts "Enter the number of the workout you'd like to see #{@@green}(1-#{@workouts.length})#{@@default}, type #{@@green}list#{@@default} to see the workouts again, or type #{@@green}exit#{@@default} to leave the program."
  end

  def invalid_input
    puts ""
    puts "Whoops! That wasn't one of the choices. Please enter a different input:"
    puts ""
  end

  def workout_menu
    workout_menu_instructions

    input = gets.strip.downcase

    if input.to_i > 0 && input.to_i <= @workouts.length
      chosen_workout = @workouts[input.to_i - 1]
      puts ""
      puts "#{@@gray_bkgd}#{@@black}-------#{chosen_workout.name}-------#{@@default_bkgd}"
      puts "#{@@green}#{chosen_workout.description}"
      puts ""
      puts "#{@@default_bkgd}#{@@gray}Source: #{@@blue}#{chosen_workout.url}#{@@default}"
      puts ""
    elsif input == "list"
      list_workouts
      workout_menu
    elsif input == "exit"
      @workout_input = "exit"
    else
      invalid_input
      workout_menu
    end
  end

  def more_workouts?
    unless @workout_input == "exit"
      puts "Would you like to see another workout? #{@@green}(y/n)#{@@default}"
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
    puts ""
    puts "See you tomorrow for your next workout!"
    puts ""
  end

end
