def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input="0")
  input=user_input.to_i
  index = input-1
end


def position_taken?(board,index)
  !(board[index] == " "|| board[index] == "" || board[index]== nil)
end

def valid_move?(board,index)
  if index.between?(0,8)== true && position_taken?(board,index) == false
    return true
  else return false
  end
end



def turn_count(board)
  counter=0
  board.each do |spot|
    if spot == "X" || spot == "O"
      counter+=1
    end
  end
    return counter
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else return "O"
end
end


def move(board, index, token)
  board[index]= token
end


def turn(board)
  puts "Please enter 1-9:"
  user_input=gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board,index) == true
    token = current_player(board)
    move(board,index,token)
    display_board(board)
  else turn(board)
  end
end


WIN_COMBINATIONS= [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [6,4,2],
  [0,4,8]
]


def won?(board)
WIN_COMBINATIONS.each do |win_combination|
win_index_1 = win_combination[0]
win_index_2 = win_combination[1]
win_index_3 = win_combination[2]
position_1 = board[win_index_1]
position_2 = board[win_index_2]
position_3 = board[win_index_3]
if position_1 == "X" && position_2 == "X" && position_3 == "X"
  return win_combination
elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
  return win_combination
end
end
return false
end


def full?(board)
  board.all? do |space|
    space != " "
  end
end


def draw?(board)
  won_answer = won?(board)
  full_answer = full?(board)
  won_answer==false && full_answer== true
end


def over?(board)
  draw?(board)== true || won?(board)!= false
end


def winner(board)
  if won?(board) != false
    win_combo = won?(board)
    board[win_combo[0]]
  end
end

def play(board)
  until over?(board)== true
    turn(board)
  end
  if won?(board)!=false
    winner_token=winner(board)
    puts "Congratulations #{winner_token}!"
  elsif draw?(board)==true
    puts "Cats Game!"
end
end
