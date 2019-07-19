require_relative './player'
require_relative './cards'

class Game
  def initialize(total_players, total_cards)
    hands, @draw_pile = Cards.deal_cards(total_players, total_cards)
    @total_cards = total_cards
    @players = hands.map.with_index { |hand, i| i == 0 ? User.new(hand, i) : AI.new(hand, i) }

    @players.each { |p| 
      puts "Player: #{p.index}"
      puts "Score: #{p.score}"
      puts "Hand: #{p.hand}"
    }

    puts "draw_pile #{@draw_pile}"
  end

  def show_scores
    puts "\n"
    puts "| Player | Score |"
    @players.each { |p| 
      puts "| #{p.index}      | #{p.score}     |"
    }
    puts "\n"
  end

  def game_is_finished?
    total_score = @players.inject(0) { |acc, p| acc + p.score }
    return total_score == @total_cards
  end

  def winner
    @players.max_by(&:score).index
  end

  def show_winning_screen
    puts "Winner is: Player #{winner}!!!"
    puts "Thanks for playing. Bye!"
  end

  def current_player(index)
    @players[index]
  end

  def get_next_player(n)
    n == @players.length - 1 ? 0 : n + 1 
  end

  def check_book(index, card)
    player = current_player(index)
    if Hand.has_book?(player.hand, card)
      player.handle_book(card)
      show_scores
    end
  end

  def handle_successful_ask(player, askee, index, card)
    player.get_card(askee, card)
    check_book(index, card)
    turn(index)
  end

  def handle_unsuccessful_ask(player, askee, index)
    drawn_card = player.go_fish(askee, @draw_pile)
    check_book(index, drawn_card) if drawn_card
    turn(get_next_player(index))
  end

  def handle_out_of_cards(message)
    print message
    player.draw_from_pile(@draw_pile)
    turn(get_next_player(index))
  end

  def ask(index, askee, card)
    player = current_player(index)
    if player.ask_card_is_successful?(askee, card)
      handle_successful_ask(player, askee, index, card)
    else 
      handle_unsuccessful_ask(player, askee, index)
    end
  end

  def user_turn
    puts "Your turn!"
    user_player = current_player(0)
    user_player.show_hand

    handle_out_of_cards("You are out of cards!") if user_player.hand.length == 0

    askee = user_player.get_askee(@players)
    card = user_player.get_card_to_ask
    ask(0, askee, card)
  end
  
  def ai_turn(index)
    puts "Player #{index} turn!"
    ai_player = current_player(index)

    handle_out_of_cards("Player #{index} is out of cards!") if ai_player.hand.length == 0

    askee = ai_player.get_askee(@players)
    card = ai_player.get_card_to_ask
    ask(index, askee, card)
  end

  def turn(index)
    if game_is_finished?
      show_winning_screen
      return
    end

    @players.each { |p| 
      puts "Player: #{p.index}"
      puts "Score: #{p.score}"
      puts "Hand: #{p.hand}"
    }

    puts "\n\n"
    puts "-" * 50
    index == 0 ? user_turn : ai_turn(index)
  end

  def run
    start_index = (0..@players.length - 1).to_a.sample
    puts "--"

    @players.each { |p|
      p.handle_initial_book
    }

    puts "Player #{start_index} starts!"
    turn(start_index)
  end
end
