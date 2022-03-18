# frozen_string_literal: true

# class that will hold the current position of the knight
# and possible future positions 
class Position
  attr_accessor :current, :possible, :history

  def initialize(current = nil, possible = nil, history = nil)
    @current = current
    @possible = possible
    @history = history
  end
end

# class for the knight that will travel the board
class Knight
  attr_accessor :starting_position, :moveset

  @@moveset = [[1,2], [2,1] ,[2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2]]

  def initialize(beginning = [1,1])
    @starting_position = Position.new(beginning)
  end

  def sum_index(array1, array2)
    temp_array = []
    array1.each_with_index do |_element, index|
      temp_array << array1[index]+array2[index]
    end
    temp_array
  end

  def legal_move?(move)
    return false if move.max > 8 || move.min < 1

    true
  end

  def next_possible_moves(position)
    possible_moves = []
    @@moveset.each do |move|
      this_move = sum_index(position, move)
      possible_moves << this_move if legal_move?(this_move)
    end
    possible_moves
  end

  def update_history(curr_position)
    if curr_position.history.nil?
      [curr_position.current]
    else 
      curr_position.history + [curr_position.current] 
    end 
  end

  def knight_moves(curr_position = @starting_position, queue = [],finish)
    return curr_position.history+[finish] if curr_position.current == finish

    curr_position.possible = next_possible_moves(curr_position.current)
    new_history = update_history(curr_position)
    curr_position.possible.each do |move|
      next_position = Position.new(move, nil, new_history)
      queue << next_position
    end
    knight_moves(queue.shift, queue,finish)
  end
end

konj = Knight.new
# p konj.next_possible_moves([4, 5])
test_position = Position.new([1,1],nil,nil)
test_position2 = Position.new([4,4],nil,nil)
p konj.knight_moves(test_position, [4,4])
p konj.knight_moves(test_position2, [1,1])