# buildable.csv documentation

This file describes the buildings and units that a city may produce.

## Fields
1. buildableID: integer, primary key, unique, not nullable.
1. name: string, not nullable.
1. classification: string from set [Building, Capital Building, World Wonder, National Wonder, Project, International Project, Guild, Civilian Unit, Naval Civilian Unit, Religious Unit, Trade Unit, Naval Trade Unit, Great Person, Naval Great Person, Ranged Unit, Melee Unit, Naval Melee Unit, Naval Ranged Unit, Siege Weapon, Mounted Unit, Gunpowder Unit, Armored Unit, Bomber Unit, Fighter Unit, Helicopter Unit, Bomb Unit], not nullable.
1. costProductionPoints: integer, not nullable, not negative. These apply to standard game speed. For International Projects, this value is the minimum required to attain the reward on a standard map with 8 civilizations.
1. costFaithPoints: integer, not nullable, not negative.
1. maintenanceCostGold: integer, nullable, not negative.
1. movementPoints: integer, nullable, not negative. Amount of movement a unit can complete in a turn.
1. dependsOnTechnologyID: integer, foreign key referencing technology.csv:technologyID, nullable. Civilization must have researched this tech before building this building or unit.
1. dependsOnBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable. Civilization must have built this building first (in this city, or in every city, depending on this buildable's classification).
1. upgradesToBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable. Unit upgrade path.
1. dependsOnSocialPolicyID: integer, foreign key referencing socialPolicy.csv:socialPolicyID, nullable. Civilization must have selected this social policy first before building this building or unit.
1. dependsOnReligiousBeliefID: integer, foreign key referencing religiousBelief.csv:religiousBeliefID, nullable. Civilization must have selected this religious belief first before building this building or unit.
1. uniqueToCivilizationID: integer, foreign key referencing civilization.csv:civilizationID, nullable. Only this civilization may build this building or unit.
1. replacesBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable. This row's buildable is available instead of this column's referenced buildable.
1. disallowedWithBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable. Cannot be built in the same city as this referenced buildable.
1. disallowedWithCivilizationID: integer, foreign key referencing civilization.csv:civilizationID, nullable. Cannot be built by this civilization.
1. combatStrength: integer, nullable, not negative. Melee strength of this unit.
1. range: integer, nullable, not negative. Number of tiles away this unit can shoot, if ranged.
1. rangedStrength: integer, nullable, not negative. Combat strength projected by this unit during a ranged attack.
1. ancientRuinsUpgradeToBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable. Ancient Ruins upgrade this unit differently than the normal upgrade path.