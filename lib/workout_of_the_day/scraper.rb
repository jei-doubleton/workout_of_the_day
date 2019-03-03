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

  end

  def self.scrape_military

  end

  def self.scrape_bodyweight

  end


end
