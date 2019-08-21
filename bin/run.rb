require_relative '../config/environment'
require 'pry'
ActiveRecord::Base.logger.level = 1
system("clear")

def welcome
    binding.pry 
    puts "Hello, Welcome to Streak Trivia. Please enter 1 to start game or 2 to see Streak Trivia's best streak!!"
    input = gets.chomp
    if input == "1"
        puts "Please enter a username to start!"
        username = gets.chomp
        save_user(username)
    elsif input == "2"
        puts "The current longest streak is..."
        puts find_highest_score
    else
        puts "Sorry, that isn't a valid entry. Please try again."
        restart_welcome
    end
end

def restart_welcome
    puts "Please enter 1 to start game or 2 to see Streak Trivia's best streak!!"
    input = gets.chomp
        if input == "1"
            puts "Please enter a username to start!"
            username = gets.chomp
            save_user(username)
        elsif input == "2"
            puts "The current longest streak is..."
            puts find_highest_score
        else
            puts "Sorry, that isn't a valid entry. Please try again."
            restart_welcome
        end
end

def game_start(username)
    puts "Welcome #{username}, you will be asked questions 
        until you get one incorrect. Answer each question by typing
        out the correct answer. If question is unanswerable, please type
        in 'pass'. Get ready to play."
    puts "------------------------------------------------------------------------"
    run_game(username, count = 0)
end


def run_game(username, count = 0)
    answers_array = []
    random_question = Question.all.sample
    exact_question = random_question.question_text
    exact_question_incorrect_choice_1 = random_question.incorrect_answer1
    exact_question_incorrect_choice_2 = random_question.incorrect_answer2
    exact_question_incorrect_choice_3 = random_question.incorrect_answer3
    exact_question_correct_answer = random_question.correct_answer
    answers_array << exact_question_correct_answer
    answers_array << exact_question_incorrect_choice_1
    answers_array << exact_question_incorrect_choice_2
    answers_array << exact_question_incorrect_choice_3
    puts exact_question
    puts answers_array.shuffle

    answer = gets.chomp
        if answer.to_s.downcase == (random_question.correct_answer.downcase)
            new_count = (count += 1)
            run_game(username, new_count)
        elsif answer.to_s.downcase == "pass"
            new_count = count
            run_game(username, new_count)
        else
            new_count = count
            puts "Sorry! That was not the correct answer :( You finished with a streak of #{count}!"
        end
    
    user = User.all.find do |user|
        user.name == username
    end

    Game.create(user_id: user.id, score: new_count)
end


def save_user(username)
    usernames = User.all.map do |user|
        user.name
    end

        if usernames.include?(username)
            puts "Welcome back #{username}! Please enter 1 to play, 2 to see your highest streak, or 3 to DELETE YOUR ACCOUNT (WE DO NOT ADVISE YOU DO THIS)"
            puts "--------------------------------------------------------------------"
            
            input = gets.chomp
                if input == "1"
                    run_game(username)
                elsif input == "2"
                    my_highest_score(username)

                elsif input == "3"
                    User.find_by(name: username).delete
                else
                    puts "Sorry, that isn't a valid entry. Please try again."
                # Come back to this and add in "previous high score method"
                end
        else
            new_user = User.create(name: username)
            game_start(username)
        end 
end

def find_highest_score
    highest_score = Game.order(score: :desc).first.score 
end

def my_highest_score(username)
    highest_score = Game.find_by(user_id: username.id).order(score: :desc)first.score
    binding.pry
end


welcome
