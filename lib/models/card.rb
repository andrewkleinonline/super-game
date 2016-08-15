class Card

  attr_accessor :attributes

  @@library =
  {
    1 =>
    {name: "Thief", power: 1, must_discard: false,
      description: "Steals a random card from the opponents hand."},
    2 => {name: "Swindler", power: 1, must_discard: true,
      description: "Steals a specified card from the opponents hand. Must discard a card to play."},
    3 => {name: "Hero", power: 2, must_discard: false,
      description: "Deals 2 damage."},
    4 => {name: "Mercenary", power: 3, must_discard: true,
      description: "Deals 3 damage. Must discard a card to play."}
  }

  def initialize(card_number)
    @attributes = @@library[card_number]
  end

  def self.library
    @@library
  end

end
