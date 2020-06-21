# era.csv documentation

This file describes the 8 eras of history that are roughly equal parts of the technology tree.

## Fields
1. eraID: integer, primary key, unique.
1. name: string.
1. sequence: integer. The order eras appear in the technology tree, from left to right ascending.
1. beginYear: integer, not null. The historic year this era begins, though individual civilizations may reach an era in any in-game year.
1. endYear: integer, nullable. The historic year this era ends, though individual civilizations may exit an era in any in-game year. The Future era has no endYear.