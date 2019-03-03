class WorkoutOfTheDay::Scraper

  def initialize
    scrape_crossfit
    scrape_rowing
    scrape_military
    scrape_bodyweight
  end

  def scrape_crossfit
    doc = Nokogiri::HTML(open("https://www.crossfit.com/workout/"))

    name = doc.search("h3 a").first.text
    url = doc.search("h3 a").first.attr("href")

    workout = WorkoutOfTheDay::Workout.new
    workout.name = "Crossfit: #{name}"
    workout.url = "https://www.crossfit.com#{url}"
    workout.description = Nokogiri::HTML(open(workout.url)).css("article div p").text
  end

  def scrape_rowing
    doc = Nokogiri::HTML(open("https://www.concept2.com/indoor-rowers/training/wod"))
    workouts = doc.search("table.daily-workout-info tr")

    workouts.collect do |w|
      workout = WorkoutOfTheDay::Workout.new
      workout.name = "Rowing: #{w.css("section h4").first.text} (#{w.css("section h3").text})"
      workout.description = "#{w.css("section h4 + p").text.strip}"
    end
  end

  def scrape_military
    doc = Nokogiri::HTML(open("http://sofwods.com/wods/"))

    workout = WorkoutOfTheDay::Workout.new
    workout.name = "Military: #{doc.css("article h2").first.text.strip}"
    workout.url = doc.css("article h2 a").first.attr("href")
    workout.description = Nokogiri::HTML(open(workout.url)).css("div.wpb_text_column.wpb_content_element p").text
  end

  def scrape_bodyweight
    doc = Nokogiri::HTML(open("http://www.thewodgenerator.com/resources/bodyweight-wods-the-definitive-list-of-149-bodyweight-workouts/"))
    workout_names = doc.css("div#wDiv h3")
    workout_names.collect.with_index do |w, i|
      workout = WorkoutOfTheDay::Workout.new
      workout.name = w.text
      workout_descriptions = doc.css("div#wDiv ol")[i].css("li")
      workout.description = workout_descriptions[rand(0..workout_descriptions.length)].text
    end
  end
end
