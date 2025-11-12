-> start
=== start ===

Beeshoy: Hallo!

* " Hallo!"
    -> Hallo_player

===Hallo_player===
Beeshoy: do you want to play a game?
*  "For Sure! Let's play!!!!"
    -> Game_player

===Game_player===
Beeshoy: What game do you want to play?
*   "Think"
    ->Think_player



===Think_player===
Beeshoy: Wow, ‘Think’ as a choice? Bold move. Didn’t realize that was optional. Hmmm, what about a story-driven game?
*   "Oh, yes, I love story-driven games — it’s like reading a book, but with quick-time events to remind you you’re still alive."
    ->Yes_player

===Yes_player===
  Beeshoy: But let’s not rush things. We’ll continue soon.

-> END


