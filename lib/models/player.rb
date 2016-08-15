class Player

  attr_accessor :hand, :health, :name, :is_human

  def initialize(name:, is_human:)
    @hand = []
    @health = 20
    @name = name
    @is_human = is_human
  end

  def add_card(card)
    self.hand << card
  end

  def draw_card
    self.add_card(Card.new(rand(4)+1))
  end

  def discard_card(card_name)
    card_index = self.hand.find_index {|card| card.attributes[:name] == card_name}
    self.hand.delete_at(card_index)
  end

  def initialize_hand
    3.times do
      self.add_card(Card.new(rand(4)+1))
    end
  end

  def display_hand
    @hand.each_with_index do |card,index|
      puts "#{index+1}: #{card.attributes[:name]} (#{card.attributes[:power]})"
    end
  end

  def cards_and_quantities
    quantity_hash = Hash.new
    self.hand.each do |card|
      if !quantity_hash.keys.include?(card.attributes[:name])
        quantity_hash[card.attributes[:name]] = 1
      else
        quantity_hash[card.attributes[:name]] += 1
      end
    end
    quantity_hash
  end

end
