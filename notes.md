When players log into the Minecraft server, check for changes to username and update database accordingly.  If a player's new name matches another player's name, deactivate other player's account.

This could be done through the Rails application, but a secret API key would be needed.  Otherwise, access database directly

An in-game command is needed to reclaim stolen accounts.


What if Regions and Positions could join Wars, too?
It would make sense for the controller of a region to be able to


What if Positions didn't need a Fraction?  Players could form Positions ("Groups") to loosely organize themselves.  Later, these Positions could be assimilated into Fractions.  Conquered, perhaps?


Need to track active character per user
user.active_character_id attribute:
-only have to update user object when this is changed
-cannot get list of active characters

character.active attribute:
-bad

join table:
-weird
