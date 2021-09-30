#responsible communicating between user and the data 

#Good Morning, what is your name?
#Would you like todays news today?
#Select a news story to see more! 


class CLI 

    # a method to behave as an entry way to the cli, called upon instantialization 

    def start
        puts "Welcome to your News Hub!"
        API.get_data
        puts "Let's start with your name: "
        greet(user_input)
    end 

    def user_input 
        gets.strip
    end 
    
    def greet(name)
        puts "#{name}, that is a great name!"
        puts "Would you like to view the trending headlines of the day?"
        input
    end 

    def input
        puts "Input 'y' to see trending news or 'exit' to leave News Hub."
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
        puts "Input 'y to see the news list, 'exit' to leave News Hub."
        menu
    end 

    def news_selection 

        selection = user_input
        # #Query the news class to find that specific news list to expand on 
        news = News.find_news(selection)
        news_details(news)
    end 

    def news_details(news)
        puts ""
        puts "Title: #{news.title}"
        puts ""
        puts "Description: #{news.description}"
        puts ""
        puts "Author: #{news.author}"
        puts ""
        puts "Content: #{news.content}"
        puts ""
        # puts "URL: #{news.url}"
        input

    end 


    #based on user selection, show a list of news
    #give an error message
    #exit the program 
    def menu
        selection = user_input
        if %w(yes YES Y y).include? selection
            news_list #print the news list 
            news_selection
        elsif selection == "exit"
            goodbye #give the user a goodbye message
        else 
            invalid #give an error message and make user selection again
        end 
    end 

end 