#responsible communicating between user and the data 

#Good Morning, what is your name?
#Would you like todays news today?
#Select a news story to see more! 

require 'date'

class CLI 

    # a method to behave as an entry way to the cli, called upon instantialization 

    def start
        clear_screen
        puts "One moment... This application is currently loading.".colorize(:color =>:black, :background =>:white)
        API.get_data
        space_divider
        space_divider
        space_divider
        clear_screen
        puts "Welcome to your News Hub. Let's start with your name: "
        greet(user_input)
    end 

    def user_input 
        space_divider
        gets.strip.downcase
    end 
    
    def greet(name)
        clear_screen
        if %w(exit q quit goodbye bye).include? name 
            goodbye 
        else 
            clear_screen
            puts "You have an awesome name, #{name.capitalize}"
            space_divider
            puts "#{name.capitalize}, would you like to view the trending headlines of the day? [y/n]"
            menu
        end 
    end 

    def news_list
        space_divider
        puts "Here is the list of the top trending news today."
        hardline_divider
        space_divider
        News.all.each.with_index(1) do |article, index|
            puts "#{index}. #{article.title}"
        end 
        hardline_divider
        puts "Select an entry based on the number."
    end 

    def goodbye
        clear_screen
        space_divider
        hardline_divider
        space_divider
        puts "

        _______  __   __  _______    _______  __   __  _______  __    _         
        |  _    ||  | |  ||       |  |       ||  | |  ||       ||  |  | |        
        | |_|   ||  |_|  ||    ___|  |_     _||  |_|  ||    ___||   |_| |        
        |       ||       ||   |___     |   |  |       ||   |___ |       |        
        |  _   | |_     _||    ___|    |   |  |       ||    ___||  _    | ___    
        | |_|   |  |   |  |   |___     |   |  |   _   ||   |___ | | |   ||   |   
        |_______|  |___|  |_______|    |___|  |__| |__||_______||_|  |__||___|   
           
        ".colorize(:red)
        space_divider
        space_divider
        puts "              You chose to exit. That's okay. I won't be hurt."
        puts "                      Make sure to come again soon!"
        space_divider
        hardline_divider
        space_divider
    end 

    def invalid
        space_divider
        hardline_divider
        space_divider
        puts "Hmm, your input was invalid. Please try again."
        space_divider
        hardline_divider
        space_divider
        menu
    end 

    def news_selection 
        selection = user_input
        space_divider
        space_divider
        if %w(exit q quit goodbye bye).include? selection 
            goodbye 
        elsif  %w('a'..'z').include? selection
            puts "Uh Oh.. Your entry doesn't seem to be a number! Please try again: "
            news_selection
        else         
            selection = selection.to_i
            if selection > News.all.size 
                puts "Uh Oh.. The number you selected is invalid. Please try again and chose a valid entry: "
                news_selection
            end 
            selection = selection - 1
            news = News.find_news(selection)
            news_details(news)
            space_divider
            space_divider
        end 

    end 

    def hardline_divider
        puts "------------------------------------------------------------------------------------"
    end

    def space_divider
        puts ""
    end 

    def news_details(news)
        clear_screen
        space_divider
        puts "Title: #{news.title == nil ? "NA" : news.title}"
        hardline_divider
        puts "Description: #{news.description == nil ? "NA" : news.description}"
        hardline_divider
        puts "Author: #{news.author == nil ? "NA" : news.author} / Published Date: #{news.publishedAt == nil ? "NA" : news.publishedAt.gsub(/T.*/, '')} / Source: #{news.source["name"] == nil ? "NA" : news.source["name"]} "
        space_divider
        space_divider
        news_url = news.url
        open_link(news_url)
    end 

    def open_link(news_url)
        puts "Would you like to open this page up in your browser? [y/n]".colorize(:blue)
        selection = user_input
        if %w(exit q quit goodbye bye).include? selection 
            goodbye
        elsif %w(yes y yeah sure yep yup yea ye).include? selection
            system("open", news_url)  #open up the browser page 
            clear_screen
            puts "We took you back to the top trends!"
            space_divider
            news_list #go back to the main menu
            news_selection
        elsif %w(no n nah nay never).include? selection
            #message and go back to the main menu
            space_divider
            space_divider
            clear_screen
            puts "Not interesting? Okay, we took you back to the original list: " 
            space_divider
            news_list
            news_selection
        else 
            invalid #give an error message and make user selection again
        end         
    end 

    def clear_screen
        system('clear')
    end 

    def menu
        selection = user_input
        clear_screen
        if %w(yes y yeah sure yep yup yea ye).include? selection
            news_list #print the news list 
            news_selection
        elsif %w(no n nah nay never yup).include? selection
            puts "No it is. See you later!"
        elsif %w(exit q quit goodbye bye).include? selection 
            goodbye #give the user a goodbye message
        else 
            invalid #give an error message and make user selection again
        end 
    end 

end 