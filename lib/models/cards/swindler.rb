class Swindler

  def self.swindle_from_cpu(cpu, human)
    card_choice_number = human_choose_card
    if verify_opponent_has_card(cpu, Card.library[card_choice_number])
      human.add_card(Card.new(card_choice_number))
      cpu.discard_card(Card.library[card_choice_number][:name])
      puts "You stole a #{Card.library[card_choice_number][:name]} from the CPU!"
    else
      puts "The CPU does not have that card!"
    end
  end

  def self.swindle_from_human(cpu, human)
    card_choice_number = cpu_choose_card
    if verify_opponent_has_card(human, Card.library[card_choice_number])
      cpu.add_card(Card.new(card_choice_number))
      human.discard_card(Card.library[card_choice_number][:name])
      puts "The CPU stole a #{Card.library[card_choice_number][:name]} from you!"
    else
      puts "The CPU tried to steal a card you don't have!"
    end
  end

  def self.verify_opponent_has_card(opponent, card_choice)
    #binding.pry
    opponent.hand.any? {|card| card.attributes[:name] == card_choice[:name] }
  end

  def self.cpu_choose_card
    card_choice_number = (rand(4)+1) #random... for now?
  end

  def self.human_choose_card
    puts "Which card would you like to attempt to steal?"
    present_options
    card_choice_number = gets.strip
    if !(1..4).include?(card_choice_number.to_i)
      puts "That is not a valid option. Please enter a valid option."
      human_choose_card
    end

    card_choice_number.to_i
  end

  def self.present_options
    Card.library.each do |card_number, attributes|
      puts "#{card_number}. #{attributes[:name]}"
    end
  end

end
