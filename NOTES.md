# NOTES
These are brainstorming notes of things I need to design schemas for.

## Terrain and Reconnaissance
Finding Natural Wonders gives 1 Global Happiness.

Reveals versus Vision. E.g. Satellites reveal, but Triplane promotion to Reconnaissance gives vision.

### Sight and Fog of War
Mountains are level 3. Hills are level 2. All other terrain is level 1. Forests and jungles obstruct vision if they are on the same level as the unit. Mountains and hills obstruct vision altogether. Mountains may be seen up to 1 tile farther than a unit's normal sight range.

Some natural wonders are classified as mountains. E.g., Uluru, Mount Sinai.
Units not your own and changes to territory (like removal of forests/jungles or new improvements) are hidden when not sighted by your units.

Always see tiles up to 1 away from your territory, regardless of obstruction.

City-State Friends reveal their tiles + 1 farther. CS Allies give total vision.

Spies and Diplomats in foreign cities give vision within 2 tiles of that city.

## Diplomacy and Influence
Meeting City-States gives Gold and/or Faith.

## Units

### Promotions
- Keep or lose promotions upon upgrade

### Movement
- Can move after attacking
  - "Mounted and armored units are able to move after they have performed an attack if they have any MPs left. Note that they may perform only non-combat actions, such as pillaging or fortifying. In their case, an attack only consumes 1 MP."
  - "Certain promotions give the unit the ability to attack twice per turn if it has enough MPs. Again, each attack consumes 1 MP."
- Rough Terrain Penalty (Entering rough terrain consumes all movement.)
- No Rough Terrain Penalty
- Woodsman (Double movement rate Through Forest and Jungle. Movement bonus does not stack with roads or railroads.)
- Embarkation: move on water (all embarked land units have 2 MP per turn initially; this depends on technologies, not unit identity)
- Terrain MP costs:
  - Hill, forest, jungle, marsh: 2 MP
  - Rivers: end the unit's turn if crossed
  - Mountains: impassable (except Carthage UA, air units, helicopters)
  - Lakes: water tiles that require Embarkation
  - Oases: normal, flat
  - Natural wonders: impassable
  - Roads make all movement costs 1/2 MP; Engineering makes bridges to negate Rivers penalty; Machinery makes all movement costs on roads 1/3 MP. Railroads are variable (2 MP units = 0.2 MP railroad movement cost; 3 MP units = 0.3 railroad movement cost; 4+ MP units = 0.333333 railroad movement cost)
  - Helicopters fly over all terrain at 1 MP each; don't use Roads/Railroads
- Zone of Control means moving WITHIN 1-tile radius from an enemy allows only 1 tile movement per turn, and no attacking. But moving into ZOC and out of it doesn't do this.

### Domains
- Land units
- Sea units
- Air units

### Classes
Stack one unit per class on a tile.

- Military: land soldiers plus Helicopters
- Civilians: workers, settlers, missionaries, inquisitors, archaeologists, Great People (including Great Admiral), work boat
- Sea vessels

Non-civilian units can move "through" own and allied/neutral units, if MPs left to reach and ability to sight further tile. But cannot move through enemy units. Civilian units must always go around.

### Actions
- Pillage: 1 MP cost, damages improvement, gives 25 HP
- Attack
- Defend
- Embark
- Disembark
- Move
- Fortify / Until Healed (40% defensive bonus, no actions, heal damage) - requires available MPs but doesn't consume them. Available to most melee and ranged units; others can sleep.
- Sleep: same as Fortify but with no defensive bonus.
- Capture: available to Melee units; 1 MP cost and is a movement to that tile; is an attack for sake of unit attack rights (can still move but cannot make another attack without special abilities)

### Sight
- Extra sight (1)

### Combat
- Combat Bonus in Forest/Jungle (33)
- Heals 25 damage If Kills a Unit

#### Attack
Four types of combat: melee, ranged, naval, air. Units use Ranged Combat Strength when attacking at Range. Ranged combat may require ability to see target (except for Indirect Fire promotion), or to have another unit see it.

Combat bonuses: terrain, formation, forts/citadels, Great General/Admiral

- Unable to melee attack
- Withdraw Before Melee (Unit may withdraw when faced with melee attack)
- Penalty attacking cities (33)
- Enhance Flank Attack: Flank attack bonus increased by 50% (10% to 15%)
- Accuracy I promotion (+15% Ranged Combat Strength against Units in OPEN Terrain.)

#### Defense
Units use Combat Strength to defend against Melee units. But Ranged units use Ranged Combat Strength to defend against Ranged units or an enemy city.

- No defensive terrain bonuses

