# civilization.csv documentation

This file describes the playable civilizations, plus Barbarians, in Civilization V.

## Fields
1. civilizationID: integer, primary key, unique, not nullable.
1. name: string, not nullable.
1. adjective: string, not nullable.
1. leader: string, nullable. The historical person associated with this civilization and the persona adopted by the player or interacted with in-game. In Civ V, there is one leader per civilization and one civilization per leader. Barbarians have no leader.