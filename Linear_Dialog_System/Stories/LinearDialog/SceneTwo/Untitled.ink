-> start
=== start ===
Beeshoy: "Alright… I think now's a good time to pick up where we left off."
*   "This better be worth the wait."
    -> Wait_player
-> END

===Wait_player===
Beeshoy: we stopped at story-driven games—the perfect choice for when you’re craving the thrill of holding a controller just to watch someone else make all the decisions. Nothing screams "interactive entertainment" quite like sitting through endless monologues, pretending your one dialogue choice actually matters.
*   "It DOES matter!!! I mean, whether I die tragically or live miserably—totally different vibes."
    ->Matter_player

===Matter_player===
 Beeshoy: Ah yes, another grand story-driven adventure. Sit back, mash a button, pretend your choices shape the universe. Real groundbreaking stuff. Anyway, go ahead, pick a dialogue option. Not like it’ll change anything. The kingdom still burns either way.
*   "Hey, it matters! My choice decides if I get betrayed in Chapter 3… or Chapter 5. Huge difference."
    ->Matters_player

===Matters_player===
Beeshoy: ok?
*   "Huge difference. So, lets get back to the game and we will see whose opinion is right!"
    ->Difference_player
    
===Difference_player===
Beeshoy: Ok, but first, I was just kidding! "There’s more to unpack—but not just yet. You’ll see why soon."

-> END
