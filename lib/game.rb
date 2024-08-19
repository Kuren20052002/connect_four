require "colorize"
require_relative "grid"
require_relative "player"
RED_TOKEN = "O".colorize(:red)
YELLOW_TOKEN = "O".colorize(:yellow)

class Game
  attr_reader :player1, :player2

  def initialize(board = Array.new(6) { Array.new(7, " ") }, first = Player.new)
    @grid = board
    @player1 = first
    @player2 = Player.new(@player1.token == RED_TOKEN ? YELLOW_TOKEN : RED_TOKEN)
    @current_player = @player1
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
    @grid.display
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
end
