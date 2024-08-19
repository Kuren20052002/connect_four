require "colorize"

class Grid
  attr_reader :grid

  def initialize(squares = Array.new(6) { Array.new(7, " ") })
    @grid = squares
  end

  def drop_token(column, token)
    return nil unless valid_move?(column)

    (0..5).each do |row|
      if @grid[row][column - 1] == " "
        @grid[row][column - 1] = token
        break
      end
    end
  end

  def display
    puts "\n\n   1     2     3     4     5     6     7   "
    puts "+ --- + --- + --- + --- + --- + --- + --- +"
    @grid.reverse.each do |row|
      row_string = ""
      row.each do |cell|
        row_string << "|  #{cell}  "
      end
      puts "#{row_string}|"
      puts "+ --- + --- + --- + --- + --- + --- + --- +"
    end
  end

  def valid_move?(column)
    return false unless column.between?(1, 7)
    return false unless @grid[5][column - 1] == " "

    true
  end
end
