#responsible to making a call to an api 
#getting the data necessary 
#creating new ruby objects with that data 

require 'pry'

class API

    BASE_URL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=152739ec892148ed8d2495c65dfb92d3"
    API_KEY = "152739ec892148ed8d2495c65dfb92d3"

    def self.get_data
        response = RestClient.get(BASE_URL)
        news_array = JSON.parse(response)["articles"]
        news_array.each do |news|
            News.new(news)
        end 
    end 

end 







#what do I want from the api 
#First Level: (source) Title
#Second Level: Title, Description, author, source, published date 
#Third Level: Open URL, email article to a friend 


#Stretch Goals 
#Change language and country 
#change query 