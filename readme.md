# Ruby Mastermind
Mastermind is a logical guessing game where a player must guess a secret code in a certain number of tries following the feedback given. 
The code is comprised of one of the following colors randomly selected: Red, Green, Blue, Yellow, Brown, Orange, Black, White.
The feedback consists of up to 4 pegs colored red or White.
Red = one of the colors is correct(present in the code) and in the correct position
White = one of the colors is correct, but not in the correct position

## Human as guesser
The computer will randomly generate a hidden code. The human will have 10 tries to guess the code. After each try, feedback will be provided by the computer

## Human as code generator
The human will come up with a code. The computer will make 10 guesses(randomly), with the human choosing what feedback to give.

