require_relative '../config/environment'
require 'pry'
ActiveRecord::Base.logger.level = 1
system("clear")

def welcome
    puts "Hello, Welcome to Streak Trivia. Please enter your full name to play."
    username = gets.chomp
    game_start(username)
end

def game_start(username)
    # if User.all.name.include?(username)
        # "Welcome back #{username}!!! Hopefully you can beat your score from last game 
        #of {username.id.score}. Like last time, you will be asked questions until you get one incorrect. 
        #Answer each question by typing out the correct answer. Ready to play?"
    # else
        puts "Welcome #{username}, you will be asked questions until you get one incorrect. Answer each question by typing out the correct answer. If question is unanswerable, please type in 'pass'. Get ready to play."
        puts "************************************************"
    # end
    run_game
end


def run_game(count = 0)
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
        run_game(new_count)
    elsif answer.to_s.downcase == "pass"
        new_count = count
        run_game(new_count)
    else 
        puts "Sorry! That was not the correct answer :( You finished with a streak of #{count}!"
    end
end


welcome
