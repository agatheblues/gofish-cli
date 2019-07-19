module Cards
  $cards =  ["2", "3", "4", "5", "6", "7", "8", "9", "10", 'J', 'Q', 'K', 'A']
  $cards_to_deal = {
    2 => 7,
    3 => 6,
    4 => 5
  }

  def self.get_total_cards_per_player(total_players)
    $cards_to_deal[total_players]
  end

  def self.generate_cards(total_cards)
    ($cards.shuffle[0, total_cards] * 4).shuffle
  end

  def self.deal_cards(total_players, total_cards = $cards.length)
    cards = self.generate_cards(total_cards)
    total_cards_per_player = self.get_total_cards_per_player(total_players)
    hands = []
  
    total_players.times { hands << cards.shift(total_cards_per_player) }
    return [ hands, cards ]
  end
end
