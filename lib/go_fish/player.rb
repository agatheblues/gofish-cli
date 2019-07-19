require_relative 'hand'

class Player
  include Hand

  attr_accessor :hand
  attr_accessor :score
  attr_reader :index

  def initialize(hand, index)
    @hand = hand
    @score = 0
    @index = index
  end
  
  def draw_from_pile(draw_pile)
    card = draw_pile.shift
    if card
      Hand.add_card(@hand, card)
      puts "Draw pile has #{draw_pile.length} cards left!"
    else
      puts "Draw pile is empty!"
    end
    return card
  end

  def go_fish(player, draw_pile)
    puts "Player #{player.index} says: Go Fish! Player #{@index} goes fishing..."
    return draw_from_pile(draw_pile)
  end

  def ask_card_is_successful?(player, card)
    puts "Player #{@index} asks Player #{player.index} for the card #{card}..."
    return Hand.has_card?(player.hand, card)
  end

  def get_card(player, card)
    count = player.hand.count(card)
    count_cards = count > 1 ? "#{count} cards" : "one card"
    puts "Player #{player.index} gives Player #{@index} #{count_cards} #{card}!"

    Hand.add_cards(@hand, [card] * count)
    Hand.remove_card(player.hand, card)
  end

  def handle_initial_book
    potential_book =  Hand.has_initial_book?(@hand)
    potential_book.each { |card| handle_book(card) }
  end

  def handle_book(card)
    puts "\n"
    puts "Player #{@index} has a book! Player #{@index} scores one point."
    Hand.remove_book(@hand, card)
    @score += 1
  end
end

class User < Player
  def show_hand
    puts "Your hand: #{@hand.sort}"
  end

  def go_fish(player, draw_pile)
    super(player, draw_pile)
    show_hand
  end

  def get_askee(players)
    print "Choose a player to ask a card for. Enter the player index: "
    index = $stdin.gets.chomp.to_i
    askee = players[index]
    # TODO: verify index
    return askee
  end

  def get_card_to_ask
    print "Choose a card to ask for: "
    card = $stdin.gets.chomp
    # TODO: verify card
  end
end

class AI < Player
  def get_askee(players)
    players_copy = players.dup
    players_copy.delete_at(@index)
    return players_copy.sample
  end

  def get_card_to_ask
    @hand.sample
  end
end
