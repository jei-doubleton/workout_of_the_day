class WorkoutOfTheDay::Scraper

  def self.scrape_workouts
    scrape_crossfit
    scrape_rowing
    scrape_military
    scrape_bodyweight
  end

  def self.scrape_crossfit
    doc = Nokogiri::HTML(open("https://www.crossfit.com/workout/"))

    name = doc.search("h3 a").first.text
    url = doc.search("h3 a").first.attr("href")

    workout = WorkoutOfTheDay::Workout.new
    workout.name = name
    workout.url = "https://www.crossfit.com/#{url}"
    workout
  end

  def self.scrape_rowing
    doc = Nokogiri::HTML(open("https://www.concept2.com/indoor-rowers/training/wod"))
    workouts = doc.search("table.daily-workout-info tr")

    workouts.each do |w|
      workout = WorkoutOfTheDay::Workout.new
      workout.name = "#{w.css("section h3").text}: #{w.css("section h4").first.text}"
      workout.description = "#{w.css("section h4 + p").text.chomp}"
    end
  end

  def self.scrape_military

  end

  def self.scrape_bodyweight

  end


end
