class WorkoutOfTheDay::Scraper

  def initialize
    scrape_crossfit
    scrape_rowing
    scrape_military
    scrape_bodyweight
  end

  def scrape_site(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_crossfit
    doc = scrape_site("https://www.crossfit.com/workout/")
    name = "Crossfit: #{doc.css("h3 a").first.text}"
    url = "https://www.crossfit.com#{doc.css("h3 a").first.attr("href")}"
    description = scrape_site(url).css("article").first.css("div").text.gsub(/(Post).*(comments.)/, "").gsub(/<br.*>/, "  ").strip

    WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
  end

  def scrape_rowing
    doc = scrape_site("https://www.concept2.com/indoor-rowers/training/wod")

    workouts = doc.css("table.daily-workout-info tr")

    workouts.each do |w|
      name = "Rowing: #{w.css("section h4").first.text} (#{w.css("section h3").text})"
      url = "https://www.concept2.com/indoor-rowers/training/wod"
      description = "#{w.css("section h4 + p").text.strip}"

      WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
    end
  end

  def scrape_military
    doc = scrape_site("http://sofwods.com/wods/")

    name = "Military: #{doc.css("article h2").first.text.strip}"
    url = doc.css("article h2 a").first.attr("href")
    description = scrape_site(url).css("div.content-inner").text.gsub(/(<p>)|(<br.*>)/, "&&").strip

    WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
  end

  def scrape_bodyweight
    doc = scrape_site("http://www.thewodgenerator.com/resources/bodyweight-wods-the-definitive-list-of-149-bodyweight-workouts/")
    workout_names = doc.css("div#wDiv h3")

    workout_names.each do |w|
      name = w.text
      url = "http://www.thewodgenerator.com/resources/bodyweight-wods-the-definitive-list-of-149-bodyweight-workouts/"
      workout_descriptions = doc.css("div#wDiv ol").css("li")
      description = workout_descriptions[rand(0..workout_descriptions.length-1)].text

      WorkoutOfTheDay::Workout.new(name: name, url: url, description: description)
    end
  end
end
