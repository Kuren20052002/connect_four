require "colorize"

class Player
  attr_reader :token

  def initialize(tok = pick_token)
    @token = tok
  end

  def pick_token
    print "Input 1 for red token and 2 for yellow token\n"
    input = gets.chomp.to_i
    loop do
      break if [1, 2].include?(input)

      puts "Please choose between 1 and 2"
      input = gets.chomp.to_i
    end
    input == 1 ? "O".colorize(:red) : "O".colorize(:yellow)
  end

  def make_move
    puts "Pick your move"
    gets.chomp.to_i
  end

  def to_s
    "Player #{@token}"
  end
end
