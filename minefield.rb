require 'pry'
class Minefield
  attr_reader :row_count, :column_count
  attr_accessor :cleared_cells, :mine_count, :mines

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @cleared_cells = []
    @mines = []
    mine_count.times do @mines << [rand(row_count), rand(column_count)] end
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    cleared_cells.include?([row,col])
  end

############################################
  # if !field.cell_cleared?(row, col)
  #   color = gray
  # elsif field.contains_mine?(row, col)
  #   color = Gosu::Color::RED
  # else
  #   adjacent_mines = field.adjacent_mines(row, col)
  #   color = light_gray
  # end
############################################


  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    cell_check =  [[row, col],
                   [row+1, col],
                   [row-1, col],
                   [row, col+1],
                   [row, col-1],
                   [row+1, col+1],
                   [row-1, col-1],
                   [row-1, col+1],
                   [row+1, col-1]]


   cell_check.each do |cell|
     if adjacent_mines(cell[0],cell[1]) == 0 && !contains_mine?(cell[0], cell[1])
        return cleared_cells << [cell[0], cell[1]]
     elsif adjacent_mines(cell[0],cell[1]) > 0 && !contains_mine?(cell[0], cell[1])
        return cleared_cells << [cell[0], cell[1]]
     end

     if cell[0] < @row_count
       clear(cell[0], cell[1])
     elsif cell[1] < @column_count
        clear(cell[0], cell[1])
       end
   end

    # cell_check.each do |cell|
    #   if cell[0] > @row_count
    #     return cleared_cells
    #   elsif cell[1] > @column_count
    #     return cleared_cells
    #   end
    #
    #   if adjacent_mines(row, col) > 0
    #     cleared_cells << [row, col]
    #     return cleared_cells
    #   elsif adjacent_mines(row, col) == 0
    #     cleared_cells << [row, col]
    #     return cleared_cells
    #   end
    # end

    cleared_cells
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    false
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    false
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    cell_check = [[row+1, col],
                   [row-1, col],
                   [row, col+1],
                   [row, col-1],
                   [row+1, col+1],
                   [row-1, col-1],
                   [row-1, col+1],
                   [row+1, col-1]]

    count = 0
    cell_check.each do |cell|
      if contains_mine?(cell[0],cell[1])
        count +=1
      end
    end
    # clear_these.each do |clear_cell|
    #   cleared_cells << [clear_cell]
    count

  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    if @mines.include?([row, col])
      true
    end
  end
end
