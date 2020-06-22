# buildable.csv documentation

This file describes the buildings and units that a city may produce.

## Fields
1. buildableID: integer, primary key, unique.
1. name: string, not nullable.
1. classification: string from set [Building, Capital Building, World Wonder, National Wonder, Project, International Project, Guild, Unit], not nullable.
1. costProductionPoints: integer, not nullable, not negative.
1. maintenanceCostGold: integer, not nullable, not negative.
1. dependsOnTechnologyID: integer, foreign key referencing technology.csv:technologyID, not nullable.
1. dependsOnBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable.
1. uniqueToCivilizationID: integer, foreign key referencing civilization.csv:civilizationID, nullable.
1. replacesBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable.
1. givesFreeBuildableID: integer, foreign key referencing buildable.csv:buildableID, nullable.