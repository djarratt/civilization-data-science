# technology.csv documentation

This file describes the technologies that make up the technology tree. The tree is a directed acyclic graph, where each node is laid out by game designers in one cell on a grid 18 columns wide by 10 rows high.

## Fields
1. technologyID: integer, primary key, unique, not nullable.
1. eraID: integer, foreign key referencing era.csv:eraID, not nullable.
1. name: string, not nullable.
1. costSciencePoints: integer, not nullable. The base amount this technology costs to obtain, though the game contains many modifiers that affect the actual final cost.
1. columnOnTree: integer, not nullable. The column this technology is placed on in the tree's grid layout. Each column has a higher base science cost than the previous column, and therefore higher column values roughly correspond to later historic years. 
1. rowOnTree: integer, not nullable. The row this technology is placed on in the tree's grid layout. Rows have no historic connotation, though technologies are organized so that arrows (i.e., edges) may run parallel or overlap but never cross.
1. notes: string, nullable. Special notes about this technology.