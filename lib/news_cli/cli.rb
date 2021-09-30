#responsible communicating between user and the data 

#Good Morning, what is your name?
#Would you like todays news today?
#Select a news story to see more! 


class CLI 

    # a method to behave as an entry way to the cli, called upon instantialization 

    def start
        puts "Welcome to your News Hub!"
        puts "Let's start with your name: "
        greet(user_input)
    end 

    def user_input 
        gets.strip
    end 
    
    def greet(name)
        puts "#{name}, that is a great name!"
        puts "Would you like to view the top news of the day, #{name}?"
        puts "Input 'y to see the news list, 'exit' to leave News Hub."
        menu
    end 

    def news_list
        ["article 1", "article 2", "article 3"].each.with_index(1) do |article, index|
            puts "#{index}. #{article}"
        end 
    end 

    def goodbye
        "You chose to exit. That's okay. I won't be hurt."
    end 

    #based on user selection, show a list of news
    #give an error message
    #exit the program 

    def menu
        selection = user_input
        if selection == "y"
            #print the news list 
            puts "you clicked yes!"
            news_list
        elsif selection == "exit"
            #give the user a goodbye message
            puts "you want to exit, boo"
            goodbye

        else 
            #give an error message and make user selection again
            puts "this is invalid. Select again"
            puts ""
            puts "Input 'y to see the news list, 'exit' to leave News Hub."
            menu
        end 
    end 

end 