-> start

=== start ===

Butler: So... you found me. But I didn't do it. I swear it on my final breath.
* ["Then tell me who did."]
    -> reveal_beeshoy
* ["Lies. You ran, that’s guilt enough."]
    -> deny_butler
* ["You’re scared. But not guilty. There’s a difference."]
    -> read_butler

=== reveal_beeshoy ===
Butler: You’ve seen Beeshoy play both guide and fool. Ever wonder why he’s always one step ahead?
* ["Beeshoy? That doesn't make sense..."]
    -> suspicion_rises
* ["You’re deflecting. Still sounds like guilt to me."]
    -> player_doubts
* ["You’re not the first to whisper that name."]
    -> connecting_dots
=== deny_butler ===
Butler: I ran because I saw too much… not because I *did* anything. The truth burns, and Beeshoy lit the match.
* ["That’s a bold accusation."]
    -> suspicion_rises
* ["Still trying to pass blame, huh?"]
    -> player_doubts
* ["So Beeshoy… he’s not just a character?"]
    -> connecting_dots

=== read_butler ===
Butler: Thank you... I hoped someone would see it. Beeshoy hides behind charm—but death follows his script.

* ["That’s a bold accusation."]
    -> suspicion_rises
* ["Still trying to pass blame, huh?"]
    -> player_doubts
* ["So Beeshoy… he’s not just a character?"]
    -> connecting_dots
    
=== suspicion_rises ===
Butler: It is. And one that just got me killed.

* ["Wait—what do you mean?"]
    -> final_moment

=== player_doubts ===
Butler: Doubt me all you like… but remember who writes the story you’re living.

* ["What story are you talking about?"]
    -> final_moment

=== connecting_dots ===
Butler: Not just a character. He’s the narrator, the director… and maybe the executioner too.

* ["Then he's been watching everything..."]
    -> final_moment

=== final_moment ===
Butler: He won’t let me say more. You were never supposed to find me.



-> END
