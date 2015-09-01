# Terminal Chess


## Description
A game of chess, designed to be played in the terminal. Humans can play against a simple chess AI that will place the other player in check if available, or capture pieces if possible.

## Instructions
* clone the repository, navigate to it
```
ruby game.rb
```
* Use W, A, S, D to move left, up, right and down
* enter to select a piece, enter to place it on the board

## Implementation 
This game of chess is built entirely in ruby, and designed to be played in the terminal. It utilizes class inheritance to keep code DRY by placing pieces into categories (Steppable, Slidable).
