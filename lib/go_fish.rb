require_relative './go_fish/game'

module Gofish
  def Gofish.get_total_players
    ARGV.first.to_i
  end

  def Gofish.init
    total_players = Gofish.get_total_players

    if total_players < 2
      puts "This game should have at least two players"
      return
    end

    puts "Creating the game with #{total_players} players..."
    total_cards = $stdin.gets.chomp.to_i
    game = Game.new(total_players, total_cards)
    game.run
  end
end

Gofish.init