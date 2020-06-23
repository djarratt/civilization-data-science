# internationalProject.csv documentation

This file describes the three International Projects available to which a civilization can contribute production. While Projects apply just to a single civilization, an International Project is collaboratively built and effects are awarded to the top civilizations by production points.

## Fields
1. internationalProjectID: integer, primary key, unique, not nullable.
1. name: string, not nullable.
1. projectValue: integer, not nullable. The actual total required for the world to build this project follows a formula that is this project value, multiplied by the number of civilizations at the beginning of the game, multiplied by a game speed modifier, multiplied by 10.