require 'pry'
require 'rest-client'

response_string = RestClient.get("https://opentdb.com/api.php?amount=50&category=9&difficulty=easy&type=multiple")

response_hash = JSON.parse(response_string)

response_hash["results"].each do |hash|
    Question.create(
        question_text: hash["question"],
        correct_answer: hash["correct_answer"],
        incorrect_answer1: hash["incorrect_answers"][0],
        incorrect_answer2: hash["incorrect_answers"][1],
        incorrect_answer3: hash["incorrect_answers"][2]
    )
end
