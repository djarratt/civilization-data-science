# technologyDependency.csv documentation

This file describes how technologies relate to each other on the directed acyclic graph of the technology tree. That is, this file describes the connections between technologies. These may be one-to-one, one-to-many, many-to-one, or many-to-many relationships.

## Fields
1. technologyID: integer, foreign key referencing technology.csv:technologyID. This refers to the technology a player wants to research: the child, or dependent, or downstream technology.
1. dependsOnTechnologyID: integer, foreign key referencing technology.csv:technologyID. This refers to a technology that must already be researched beforehand: the parent, or earlier, or upstream technology.
