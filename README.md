# Hold’em Poker Simulator
##### (job appliance test task)
 
 
### Task:
* write classes and methods without code (design the code)
* write program in ruby
* write tests (TDD) *(actually TDD supposed to have test **before** code, of which I'm not a fan)*

### Flow
It’s necessary to implement Hold‘em poker simulator. 
One game round consists of following steps:
1. Initialize deck
1. Deal 2 cards to each player (pre-flop)
1. Put 3 cards on the table (flop)
1. Put 1 more card on the table (turn)
1. Put 1 more card on the table (river)
1. Determine winner

Each player constructs 5-card combination (hand) using 2 cards in his (her) hand and 5 cards on the table. 
Player who has best 5-card combination wins.

#### Deck
Standard 52 cards deck.

Card faces: `2 3 4 5 6 7 8 9 T J Q K A`

Card suits: `H S C D`

Cards:	
* 2H - two of hearts  
* KD - king of diamonds  
* QC - queen of clubs  
	
#### Hand types
From lowest to highest:
* High card	`2H 3C 6D 9S JS`
* One pair	`2H 3C 6D JD JS`
* Two pair	`2H 3C 3D JD JS`
* Three of a kind	`2H 7D JC JD JS`
* Straight	`2H 3D 4C 5S 6D`
* Flush	`2H 5H 9H JH AH`
* Full house	`7H 7D JC JD JS`
* Four of a kind	`7H JH JC JD JS`
* Straight flush	`9H TH JH QH KH`

#### Additional comparisons
* High	`2H 3C 6D 9S JS	>	2H 3C 6D 7S JS`
* Pair	`2H 3C 6D JD JS	>	2H 3C 5D JD JS`
* Two pair	
    * `2H 3C 3D JD JS	>	2H 9C 9D TD TS`
    * `3H 9C 9D TD TS	>	2H 9C 9D TD TS`
* Three of a kind	
    `3H 7D JC JD JS	>	2H 7D JC JD JS`
* Straight	
    * `2H 3D 4C 5S 6D	>	AC 2H 3D 4C 5S`
	* `(AC 2H 3D 4C 5S is also Straight)`
* Flush	`2H 5H 9H JH AH	>	2H 5H 9H TH AH`
* Full house	`7H 7D JC JD JS	>	JH JD 7C 7D 7S`
* Four of a kind	`7H JH JC JD JS	>	6H JH JC JD JS`
* Straight flush	
    * `9H TH JH QH KH	>	8H 9H TH JH QH`
	* `(AS 2S 3S 4S 5S is also Straight flush)`

#### Comparison method
* Input:	two 5-card “hands”
* Output:	
     * 1 - first hand is better
     * 0 - hands are equal
     * -1 - second hand is better

### Simulation output example
--- Round 0 ---  
Player A hand:	`AD KD`  
Player B hand:	`AC TD`  
Player C hand:	`QD QC`  
  
Table on flop:	`2D 5C 7D`   
Table on turn:	`2D 5C 7D QH`   
Table on river:	`2D 5C 7D QH 4D`   
 
Player A win:	`2D 4D 7D KD AD (flush)`  




# How to run the code
Do `bundle install` before starting.

`rspec` will run tests.

`./main` will run the simulation.

