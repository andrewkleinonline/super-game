class Thief

  def self.steal_from_cpu(cpu, human)
    stolen_card = cpu.hand.sample
    human.add_card(stolen_card)
    binding.pry
    cpu.discard_card(stolen_card.attributes[:name])
    puts "You stole a #{stolen_card.attributes[:name]} from the CPU!"
  end

  def self.steal_from_human(cpu, human)
    stolen_card = human.hand.sample
    cpu.add_card(stolen_card)
    human.discard_card(stolen_card.attributes[:name])
    puts "The CPU stole a #{stolen_card.attributes[:name]} from you!"
  end

end
