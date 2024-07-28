# CLI Chess Game

This is a command-line interface (CLI) chess game implemented in Ruby as part of The Odin Project curriculum. It allows two players to play a game of chess in the terminal.

## Features

- Full implementation of basic chess rules
- Two-player gameplay
- Command-line interface for move input
- Display of the chess board after each move
- Check detection

## Installation

1. Ensure you have Ruby installed on your system.
2. Clone this repository:
   ```
   git clone https://github.com/your-username/cli-chess-ruby.git
   ```
3. Navigate to the project directory:
   ```
   cd cli-chess-ruby
   ```

## How to Play

1. Run the game:
   ```
   ruby main.rb
   ```
2. Follow the on-screen prompts to make moves.
3. Enter moves in the format: `source_column, source_row destination_column,destination_row`
   For example: `3,1 3,3` to move the piece at (3,1) to (3,3).

## Current Limitations

- Castling is not yet implemented
- Pawn promotion is not available
- The game does not yet prevent moves that fail to resolve a check situation
- Does not include other termination conditions like stalemate, Dead Position, etc.

## Future Improvements

- Implement castling
- Add pawn promotion
- Enhance check handling to disallow moves that don't resolve check
- Implement an AI opponent for single-player mode

## Acknowledgements

- This project was completed as part of [The Odin Project](https://www.theodinproject.com/) curriculum.
- Special thanks to Claude for providing guidance and code improvements during the development process.