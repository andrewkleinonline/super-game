class CLI

  def run
    greet
    @cpu = Player.new(name: "CPU", is_human: false)
    @human.initialize_hand
    @cpu.initialize_hand
    puts "Here is your initial hand:"
    @human.display_hand
    display_health
    process_move(request_move, @human)
  end

  def process_move(move, player)
    if (1..player.hand.size).include?(move.to_i)
      move = move.to_i
      selected_card = player.hand[move-1]
      if selected_card.attributes[:must_discard]
        if check_if_player_can_discard(player)
          discard_card_process(selected_card.attributes[:name], player)
        else
          puts "You cannot play this card because you have no cards to discard. Select another card or pass."
          process_move(request_move, player)
        end
      end
      if selected_card.attributes[:name] == "Thief"
        if player.name=="CPU"
          Thief.steal_from_human(@cpu, @human)
        else
          Thief.steal_from_cpu(@cpu, @human)
        end
      end


      if selected_card.attributes[:name] == "Swindler"
        #Swindler.steal
        #choose card, get it if opponent has it
      end
      damage_cpu(selected_card.attributes[:power])
      player.discard_card(selected_card.attributes[:name])
      cleanup
    elsif move == "pass"
      puts "pass"
    elsif move == "exit"
      exit
    else
      puts "Input not understood. Enter a valid card number or 'exit'."
      process_move(request_move, player)
    end
  end

  #def swindler_choice

  def cleanup
    if @cpu.health < 0
      puts "You win!"
      exit
    elsif @human.health < 0
      puts "You lose :("
      exit
    else
      display_health
      draw_card(@human)
      @human.display_hand
      process_move(request_move, @human)
    end
  end

  def draw_card(player)
    player.draw_card
  end

  def damage_cpu(damage)
    @cpu.health -= damage
    puts "You strike your opponent for #{damage} damage!"
  end

  def check_if_player_can_discard(player)
    player.hand.size > 1
  end

  def discard_card_process(played_card_name, player)
    puts "Select a card to discard:"
    discard_options = player.cards_and_quantities
    discard_options[played_card_name] -= 1
    discard_options.delete_if {|card_type, quantity| quantity == 0}

    display_discard_options(discard_options)
    get_discard_choice(discard_options, player)
  end

  def get_discard_choice(discard_options, player)
    discard_choice = get_user_input
    if (1..discard_options.size).include?(discard_choice.to_i)
      discard_choice = discard_choice.to_i
      discard_name = discard_options.keys[discard_choice-1]
      player.discard_card(discard_name)
    elsif discard_choice == "exit"
      exit
    elsif discard_choice == "cancel"
      process_move(request_move, player)
    else
      puts "Input not valid. Enter a valid option."
      get_discard_choice(discard_options, player)
    end
  end

  def display_discard_options(discard_options)

    discard_options.each_with_index do |card, index|
      puts "#{index+1}. #{card[0]}, In hand: #{card[1]}"
    end
  end

  def greet
    puts "Welcome to the game! What is your name?"
    @human = Player.new(name: get_user_input, is_human: false)
    puts "Hello, #{@human.name}. Enter exit at any time to exit the game."
  end

  def get_user_input
    gets.strip
  end

  def request_move
    puts "What card would you like to play?"
    get_user_input.downcase
  end

  def display_health
    puts "#{@human.name}'s health: #{@human.health}. CPU's health: #{@cpu.health}."
  end

end
