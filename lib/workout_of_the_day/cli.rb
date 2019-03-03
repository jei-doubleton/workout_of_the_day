class WorkoutOfTheDay::CLI
  attr_reader :workout_input, :workout

  @@grn = "\e[1;32m"
  @@blue = "\e[34m"
  @@gray = "\e[37m"
  @@gray_bkgd = "\e[47m"
  @@black = "\e[30m"
  @@default = "\e[39m"
  @@default_bkgd = "\e[49m"

  def call
    load_workouts
    @workout_input = nil
    while @workout_input != "exit"
      list_workouts
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
    puts "Enter the number of the workout you'd like details on, type list to see the workouts again, or type exit to leave the program."
  end

  def invalid_input
    puts "Invalid input."
    workout_menu_instructions
  end

  def workout_menu
    workout_menu_instructions
    @workout_input = gets.strip.downcase

    if @workout_input.to_i > 0
      puts ""
      puts "#{@@gray_bkgd}#{@@black}-------#{@workout[@workout_input.to_i - 1].name}-------#{@@default_bkgd}"
      puts "#{@@blue}#{@workout[@workout_input.to_i - 1].description}"
      puts ""
      puts "#{@@default_bkgd}#{@@gray}From: #{@workout[@workout_input.to_i - 1].url}#{@@default}"
      puts ""
    elsif @workout_input == "list"
      list_workouts
    elsif @workout_input != "exit"
      invalid_input
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
