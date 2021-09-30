#what do you want your object model to look like 


class News
    @@all = []

    attr_accessor :title, :description, :author, :source

    # def initialize(title, description, author)
    #     @title = title
    #     @description = description
    #     @author = author
    #     @source = source 
    #     save
    # end 

    def initialize(news_hash)
        news_hash.each do |k, v|
            self.send("#{k}=", v) if self.respond_to?("#{k}=")
        end 
    end 

    def save 
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.find_news(news_title)
        self.all.find do |news|
            news.title == news_title 
        end 
    end 
end 