require 'pry'

require_relative 'models/card'
require_relative 'models/player'
require_relative 'models/cards/thief'
require_relative 'models/cards/swindler'

require_relative 'cli'

  #binding.pry
CLI.new.run
