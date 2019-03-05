class WorkoutOfTheDay::Scraper

  def initialize
    scrape_crossfit
    scrape_rowing
    scrape_military
    scrape_bodyweight
  end

  def scrape_crossfit
    doc = Nokogiri::HTML(open("https://www.crossfit.com/workout/"))

    name = "Crossfit: #{doc.css("h3 a").first.text}"
    url = "https://www.crossfit.com#{doc.css("h3 a").first.attr("href")}"
    description = Nokogiri::HTML(open(url)).css("article").first.css("div p").text.gsub("Post reps completed to comments", "")

    workout = WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
  end

  def scrape_rowing
    doc = Nokogiri::HTML(open("https://www.concept2.com/indoor-rowers/training/wod"))
    workouts = doc.css("table.daily-workout-info tr")

    workouts.collect do |w|
      name = "Rowing: #{w.css("section h4").first.text} (#{w.css("section h3").text})"
      url = "https://www.concept2.com/indoor-rowers/training/wod"
      description = "#{w.css("section h4 + p").text.strip}"

      WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
    end
  end

  def scrape_military
    doc = Nokogiri::HTML(open("http://sofwods.com/wods/"))

    name = "Military: #{doc.css("article h2").first.text.strip}"
    url = doc.css("article h2 a").first.attr("href")
    description = Nokogiri::HTML(open(url)).css("div.wpb_text_column.wpb_content_element p").text

    WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
  end

  def scrape_bodyweight
    doc = Nokogiri::HTML(open("http://www.thewodgenerator.com/resources/bodyweight-wods-the-definitive-list-of-149-bodyweight-workouts/"))
    workout_names = doc.css("div#wDiv h3")

    workout_names.collect.with_index do |w, i|
      name = w.text
      url = "http://www.thewodgenerator.com/resources/bodyweight-wods-the-definitive-list-of-149-bodyweight-workouts/"
      workout_descriptions = doc.css("div#wDiv ol")[i].css("li")
      description = workout_descriptions[rand(0..workout_descriptions.length-1)].text

      WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
    end
  end
end
