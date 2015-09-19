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

end
