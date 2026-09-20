# ideadump  
File for recording some ideas…

- High speed game
- Hitting obstacle = Game over
- Running + Dropping + Grappling
- Goal could be either reaching the end of the level (in the least amount of time possible) or surviving as much as possible

* 3D
* Third person
* Infinite speed

Maybe doing some other idea might be better, specially because i'm working alone for the jam

## idea 2

A game where you have to take damage to deal damage
- probably a roguelike
- topdown?
- taking damage fills a gauge that you use to attack
- you have a dash to get out of danger and must seek healing before you die
- goal is to remain alive for as long as possible
- a nice challenge is to calculate the damage you'll receive from enemies on the fly to know if it will end your run or just give you a nice amount in the gauge

## idea 3 ← Chosen idea

A fast-paced party game where you have to die before your oponents
- single-screen platformer
- you **have** to attack every few seconds and it does not work to just attack a wall
- characters can attack, heal and apply knockback to enemies
- maybe attacks are used in both facing and back sides of player to avoid attacking walls
- weirdly, seems like the simplest to make, as the focus is on the player controller and it's supposed to use a camera with a fixed position

Initially, this game could work like Stick Fight: The Game, and not have a set end to matches, just an ongoing score

- Could be interesting to use the knockback "power" to push randomized weapons onto other players to make them deal more damage
- Undead characters could be a good theme
- could i make this game with only black, white and one accent color per character?

player attacks automatically after 5 seconds of no attacking
player attack should probably have some use instead of just being a burden
- right now, it only resets vertical speed so you could maybe use it to get away from danger a little
there is a chance this game would be more fun if i inverted the heal and attack functions (it would still fit on the theme btw)

---
Ok, new change
- Jumping and attacking are the same action (jumping leaves an explosion)
- There is a gauge that fills while you don't jump
    - It clears when you jump
    - The force of the jump and the range of the explosion increase based on the gauge's value

Because of that, healing is also merged with the knockback...