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
        space_divider
        space_divider
        space_divider
        puts "Welcome to your News Hub. Let's start with your name: "
        greet(user_input)
    end 

    def user_input 
        gets.strip
    end 
    
    def greet(name)
        space_divider
        hardline_divider
        space_divider
        puts "You have an awesome name, #{name.capitalize}"
        space_divider
        puts "#{name.capitalize}, would you like to view the trending headlines of the day? [y/n]"
        menu
    end 

    def news_list
        space_divider
        puts "Here is the list of the top trending news today."
        hardline_divider
        News.all.each.with_index(1) do |article, index|
            puts "#{index}. #{article.title}"
        end 
        hardline_divider
        puts "Select an entry based on the number."
        space_divider
    end 

    def goodbye
        space_divider
        hardline_divider
        space_divider
        puts "You chose to exit. That's okay. I won't be hurt."
        space_divider
        hardline_divider
        space_divider
    end 

    def invalid
        puts "Hmm, your input was invalid. Please try again."
        puts "Input 'y' to see the news list, 'exit' to leave News Hub."
        menu
    end 

    def news_selection 
        selection = user_input 
        if %w(exit q quit).include? selection 
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
        end 

    end 

    def hardline_divider
        puts "------------------------------------------------------------------------------------"
    end

    def space_divider
        puts ""
    end 

    def news_details(news)
        space_divider
        puts "Title: #{news.title == nil ? "NA" : news.title}"
        hardline_divider
        puts "Description: #{news.description == nil ? "NA" : news.description}"
        hardline_divider
        puts "Author: #{news.author == nil ? "NA" : news.author} / Published Date: #{news.publishedAt == nil ? "NA" : news.publishedAt.gsub(/T.*/, '')} / Source: #{news.source["name"] == nil ? "NA" : news.source["name"]} "
        space_divider
        news_url = news.url
        open_link(news_url)
    end 

    def open_link(news_url)
        puts "Would you like to open this page up in your browser? [y/n]"
        selection = user_input
        if %w(exit q quit).include? selection 
            goodbye
        elsif %w(yes y yeah sure yep yup yea ye).include? selection
            system("open", news_url)  #open up the browser page 
            news_list #go back to the main menu
            news_selection
        elsif %w(no n nah nay never).include? selection
            #message and go back to the main menu
            puts "Not interesting? Okay, here is the original list: " 
            news_list
            news_selection
        else 
            invalid #give an error message and make user selection again
        end         
    end 

    def menu
        selection = user_input
        if %w(yes y yeah sure yep yup yea ye).include? selection
            news_list #print the news list 
            news_selection
        elsif %w(no n nah nay never yup).include? selection
            puts "No it is. See you later!"
        elsif %w(exit q quit).include? selection 
            goodbye #give the user a goodbye message
        else 
            invalid #give an error message and make user selection again
        end 
    end 

end 