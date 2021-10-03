#what do you want your object model to look like 


class News
    @@all = []

    attr_accessor :title, :description, :author, :source, :content, :url, :publishedAt

    def initialize(news_hash)
        news_hash.each do |k, v|
            self.send("#{k}=", v) if self.respond_to?("#{k}=")
        end 
        save
    end 

    def save 
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.find_news(selection)
        self.all.find do |news|
            @@all.find_index(news) == selection
        end 
    end 
end 