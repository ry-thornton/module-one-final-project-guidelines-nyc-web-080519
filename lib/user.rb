class User < ActiveRecord::Base
    has_many :games
    has_many :questions, through: :games 

    def get_high_score
        #look through user's scores of all games played by that user
        #return the max score

    end

    def get_all_scores
        

    end

    def delete_account
        #removes instance of user from user table
        #prompt "are you sure?"

    end













end #end of User class