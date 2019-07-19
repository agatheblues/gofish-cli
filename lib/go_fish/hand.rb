module Hand
  def self.add_card(hand, card)
    hand << card
  end

  def self.add_cards(hand, cards)
    cards.each { |card| self.add_card(hand, card) }
  end

  def self.remove_card(hand, card)
    hand.delete(card)
  end

  def self.has_card?(hand, card)
    hand.include? card
  end

  def self.has_book?(hand, last_card_added)
    potential_book = hand.select { |card| card == last_card_added }
    return potential_book.length == 4
  end

  def self.remove_book(hand, last_card_added)
    hand.delete(last_card_added)
  end

  def self.has_initial_book?(hand)
    counts = Hash.new(0)
    hand.each { |card| counts[card] += 1 }
    potential_book = counts.select { |k, v| v == 4 }
    return potential_book.keys
  end
end
