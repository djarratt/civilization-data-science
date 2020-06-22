# effect.csv documentation

This file describes effects (also known as buffs and nerfs, or changes to the game) that buildings, units, civilizations, and other items give the player.

## Fields
1. buildableID: integer, foreign key referencing buildable.csv:buildableID, nullable.
1. givesFreeBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable.