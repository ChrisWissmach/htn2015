class CompetitionController < ApplicationController

	def elo(winner, loser)

		@winner = Picture.find(winner)
		@loser = Picture.find(loser)

		winner_score = @winner.elo
		loser_score = @loser.elo

    expected = 1 / (1 + 10**((loser - winner)/400))
    mult = 0;
    
    if (winner < 1200)
        mult = 30
    elsif (winner < 1600)
        mult = -0.05 *  winner + 100
    else
        mult = 10
    end
    
    elo = (mult * (1 - expected)).round

    @winner.elo = winner_score + elo
    @loser.elo = loser_score - elo

    if @winner.save && @loser.save
    	render :json => {:success => true, :message => "Elo updated"}
    else
    	render :json => {:success => false, :message => "Elo not updated"}
    end

  end
	
	
	def find_pair (photo_elo)
		var elo_search = 50
	
		until Picture.where(elo: (photo_elo - 50)...(photo_elo + 50))
			elo_search += 50
		end 
	
		bound_array = Picture.where(elo: (photo_elo - 50)...(photo_elo + 50))
		length = bound_array.length

		return bound_array[rand(length)]
	end
end
