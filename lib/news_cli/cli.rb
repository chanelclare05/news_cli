#responsible communicating between user and the data 

#Good Morning, what is your name?
#Would you like todays news today?
#Select a news story to see more! 

require 'date'


class CLI 

    # a method to behave as an entry way to the cli, called upon instantialization 

    def start
        system("clear")
        puts "One moment... This application is currently loading."
        API.get_data
        puts ""
        puts ""
        puts ""
        puts "Welcome to your News Hub. Let's start with your name: "
        greet(user_input)
    end 

    def user_input 
        gets.strip
    end 
    
    def greet(name)
        puts "You have an awesome name, #{name.capitalize}"
        puts ""
        puts "Would you like to view the trending headlines of the day, #{name.capitalize}? [y/n]"
        input
    end 

    def input
        menu
    end 

    def news_list
        puts "Select a news article for more details"
        News.all.each.with_index(1) do |article, index|
            puts "#{index}. #{article.title}"
        end 
    end 

    def goodbye
        puts "You chose to exit. That's okay. I won't be hurt."
    end 

    def invalid
        puts "Hmm, your input was invalid. Please try again."
        puts "Input 'y' to see the news list, 'exit' to leave News Hub."
        menu
    end 

    def news_selection 
        selection = user_input 

        if %w('a'..'z').include? selection
            puts "Uh Oh.. Your entry doesn't seem to be a number! Please try again: "
            news_selection
        else         
            selection = selection.to_i
            if selection > News.all.size 
                puts "Uh Oh.. The number you selected is invalid. Please try again and chose a valid entry: "
                news_selection
            end 
        end 
        selection = selection - 1
        news = News.find_news(selection)
        news_details(news)
    end 

    def news_details(news)
        puts ""
        puts "Title: #{news.title == nil ? "NA" : news.title}"
        puts "------------------------------------------------------------------------------------"
        puts "Description: #{news.description == nil ? "NA" : news.description}"
        puts "------------------------------------------------------------------------------------"
        puts "Author: #{news.author == nil ? "NA" : news.author} / Published Date: #{news.publishedAt == nil ? "NA" : news.publishedAt.gsub(/T.*/, '')}"
        puts ""
        news_url = news.url
        open_link(news_url)
    end 

    def open_link(news_url)
        puts "Would you like to open this page up in your browser? [y/n]"
        selection = user_input
        if %w(yes y yeah sure yep yup yea ye).include? selection
            system("open", news_url)  #open up the browser page 
            news_list #go back to the main menu
        elsif %w(no n nah nay never yup).include? selection
            #message and go back to the main menu
            puts "Not interesting? Okay, here is the original list: " 
            news_list
        elsif selection == "exit" || 'q' 
             goobye
        else 
            invalid #give an error message and make user selection again
        end 
        news_list
        menu
    end 




    #based on user selection, show a list of news
    #give an error message
    #exit the program 
    def menu
        selection = user_input
        if %w(yes y yeah sure yep yup yea ye).include? selection
            news_list #print the news list 
            news_selection
        elsif %w(no n nah nay never yup).include? selection
            puts "No it is. See you later!"
        elsif selection == "exit" || 'q'
            goodbye #give the user a goodbye message
        else 
            invalid #give an error message and make user selection again
        end 
    end 

end 