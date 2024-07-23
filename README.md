# cli-chess-ruby

There's the board which maintains the state of the game
Then there are players - black and white. 
There are a set of pieces with rules on how each of them moves. 

# game
@active
@game(player1, player2, board)

initialize
	player 1 -> black/white
	player 2 -> black/white
	initialize board

play_game
while true
	active -> player1/player2

	display board

	if is_it_check?
		try
			get check_action from user
		catch
			"try again"
	else
		ask action from active player
	
	try 
		change_board(action)
	catch
		"try again" 

	if is_it_checkmate?
		winner = is_it_checkmate?
		put winning message
		break

# board
@board

change_board(action)
	if !is_valid?(action)
		raise Exception

	temp = board[old_position]
	board[old_position] = blank
	board[new_position] = temp

is_valid?(action)
	if action in get_positions(@board.piece, position, board)
		return true
	else
		return false

# piece
@colour
@piece_type - king, rook, bishop, queen, knight, and pawn
@transformation_block_hashmap
	king => for i in x-1, x, x+1
				for j in y-1, y, y+1
					[i,j]

	rook => while x < 8
				if board[x][y] == blank, positions << x,y
				else positions << x,y & break
				x ++
			while y < 8
				if board[x][y] == blank, positions << x,y
				else positions << x,y & break
				y ++
		  	while x > 0		
				if board[x][y] == blank, positions << x,y, 
				else positions << x,y & break
				x --
			while y > 0		
				if board[x][y] == blank, positions << x,y, 
				else positions << x,y & break
				y --

	bishop => while x < 8 && y < 8
				if board[x][y] == blank, positions << x,y
				else positions << x,y & break
				x ++, y++
			  while x > 0 && y > 0		
				if board[x][y] == blank, positions << x,y, 
				else positions << x,y & break
				x--, y--

	queen => rook + bishop

	knight => 




possible_moves(piece, position)


