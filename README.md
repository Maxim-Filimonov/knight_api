## A Knight’s API
## Install dependencies
```
bundle install
```

## Tests
```
rspec
```

## Console
```
ruby run.rb -h
ruby run.rb -s a1 -d d3
```

Alternatively
```
chmod +x ./run.rb
./run.rb -s a1 -d d3
```

### Givens

- Standard 8x8 chessboard, and this simple notation for squares:
http://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/SCD_algebraic_notation.svg/242px-SCD_algebraic_notation.svg.png

- Standard rules of movement for the Knight piece as outlined on Wikipedia:
http://en.wikipedia.org/wiki/Knight_(chess)#Movement



### The Challenge

Write a simple ruby script which when provided with a starting position and ending position (eg, start=a1 and end=d4) prints out the results on to the console.

The response should be one of:

a) an array of possible series of moves for a knight to get from start to end square, eg,
[‘a1-b3-d4’, ‘a1-c2-b4’, ...]

NOTE:
Each square the knight travels should be listed with dashes between.
- There should be no looping paths with the same square repeated again in the same series of moves.
- The paths should be in order from shortest to longest.
- Ignore any paths which are longer than 6 squares, including the start and end square.

b) An empty array if there is no path within 6 squares.

c) An appropriate error message in case of bad data / format.

### Examples
The below examples use a short format of: start square, end square => result. Your solution can take input on the console or as arguments when running the script.

a1, a1 => bad request as any path will have a1 repeated
a1, d4 => [a1-b3-d4, a1-c2-d4, a1-c2-e3-f5-d4, a1-c2-a3-b5-d4, a1-c2-b4-c6-d4, a1-c2-e1-f3-d4, a1-b3-d2-f3-d4, a1-b3-c1-e2-d4, a1-b3-a5-c6-d4, a1-b3-c5-e6-d4]
