# technologyDependency.csv documentation

This file describes how technologies relate to each other on the directed acyclic graph of the technology tree. That is, this file describes the connections between technologies.

## Fields
1. technologyID: integer, foreign key referencing technology.csv:technologyID.
1. dependsOnTechnologyID: integer, foreign key referencing technology.csv:technologyID.
