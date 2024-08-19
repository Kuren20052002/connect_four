require "colorize"
require_relative "grid"
require_relative "player"
RED_TOKEN = "O".colorize(:red)
YELLOW_TOKEN = "O".colorize(:yellow)

class Game
  attr_reader :player1, :player2, :grid

  def initialize(board = Grid.new, first = Player.new)
    @grid = board
    @player1 = first
    @player2 = Player.new(@player1.token == RED_TOKEN ? YELLOW_TOKEN : RED_TOKEN)
    @current_player = @player1
    @turn = 0
  end

  def play
    start_message
    until @turn == 42
      handle_turn
      if game_over?
        end_message
        return
      end
      end_turn

    end
    draw_message
  end

  def handle_turn
    @grid.display
    puts "Please choose a move: "
    move = @current_player.make_move
    until @grid.valid_move?(move)
      puts "Unvalid move, please enter again"
      move = @current_player.make_move
    end
    @grid.drop_token(move, @current_player.token)
  end

  def game_over?
    return true if win_horizontal?
    return true if win_vertical?
    return true if win_diagnonal?
    return true if win_other_diagnonal?

    false
  end

  private

  def win_horizontal?
    @grid.grid.each do |row|
      (0..3).each do |idx|
        win_array = [row[idx], row[idx + 1], row[idx + 2], row[idx + 3]]
        return true if win_array.uniq.length == 1 &&
                       !win_array.include?(" ")
      end
    end
    false
  end

  def win_vertical?
    (0..6).each do |column|
      (0..2).each do |row|
        win_array = [@grid.grid[row][column], @grid.grid[row + 1][column], @grid.grid[row + 2][column],
                     @grid.grid[row + 3][column]]
        return true if win_array.uniq.length == 1 &&
                       !win_array.include?(" ")
        # Conditions to check if 4 continious of the same column is the same token
        # and those four don't contain the default value
      end
    end
    false
  end

  def win_diagnonal?
    (0..6).each do |column|
      (0..2).each do |row|
        win_array = [@grid.grid[row][column], @grid.grid[row + 1][column + 1], @grid.grid[row + 2][column + 2],
                     @grid.grid[row + 3][column + 3]]
        return true if win_array.uniq.length == 1 &&
                       !win_array.include?(" ")
        # Conditions to check if 4 continious of the same column is the same token
        # and those four don't contain the default value
      end
    end
    false
  end

  def win_other_diagnonal?
    (0..6).each do |column|
      2.downto(0).each do |row|
        win_array = [@grid.grid[row + 3][column], @grid.grid[row + 2][column + 1], @grid.grid[row + 1][column + 2],
                     @grid.grid[row][column + 3]]
        return true if win_array.uniq.length == 1 &&
                       !win_array.include?(" ")
        # Conditions to check if 4 continious of the same column is the same token
        # and those four don't contain the default value
      end
    end
    false
  end

  def start_message
    puts "\n\n🎉 Welcome to Connect Four! 🎉"
    puts "Get ready for an epic battle of strategy and skill! 🤔💥"
    puts "May the best player win! 🏆"
    puts "Let the games begin! 🚀"
  end

  def draw_message
    @grid.display
    puts "\n🎉 It's a Draw! 🎉"
    puts "Wow, what a game! 🤯"
    puts "Both players played brilliantly and left it all on the board. 👏👏"
    puts "No winner this time, but it was an epic match! 🏆"
    puts "Thanks for playing, and get ready for the next challenge! 🚀"
  end

  def end_message
    @grid.display
    winner = @current_player == @player1 ? "Player 1" : "Player 2"
    puts "\n🎉 Game Over! 🎉"
    puts "What an incredible match! 💪"
    puts "👏 Both players gave it their all, but..."
    puts "🥇 Congratulations to #{winner}! 🥳"
    puts "You've emerged victorious! 🏆"
    puts "Thanks for playing, and see you next time! 👋"
  end

  def end_turn
    @current_player = @current_player == @player1 ? @player2 : @player1
    @turn += 1
  end
end
