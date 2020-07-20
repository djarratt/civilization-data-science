# resource.csv documentation

This file describes resources spawned on map tiles.

## Fields
1. resourceID: integer, primary key, unique, not nullable.
1. name: string, not nullable.
1. classification: string from set [Bonus, Strategic, Luxury], not nullable.
1. dependsOnTechnologyID: integer, foreign key referencing technology.csv:technologyID, nullable. Civilization must have researched this tech before this resource is visible and usable.