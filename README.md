# Civilization Data Science
This repo contains data and scripts for analysis of Sid Meier's Civilization V, such as machine learning and visualization approaches to understanding the game's structure. While this approach would work for all Civilization games, the first release covers Civilization V including all expansions through Brave New World. Please visit https://civilization.com/ to purchase and enjoy one of the Civilization games! I have no legal rights or interest to anything surrounding Civilization, and its intellectual property and trademarks are the property of their respective owners.

This repo is a work in progress. Civ V is a complex game and it will take me a while to structure its metadata in a manner appropriate for data science scripts to use.

## License

Unlicense. No license whatsoever. I credit the makers of Civilization V for their hard work and creativity, and am grateful I can contribute a dataset meant to analyze their game. If you use this dataset, I would appreciate a citation (https://orcid.org/0000-0002-0352-8682) or note.

## Acknowledgements

### Data structure
The data structures that make up this repo are akin to a SQL database in third normal form, though implemented in CSV for ease of version control, transparency, and interoperability.

The specific structures are inspired by Civilization V's design, but are my own work.

Table row order has no meaning, unless there is a sequence column or another column to indicate order or spatial information.

### Data source

The original data source is Sid Meier's Civilization V game by Firaxis ([official site](https://civilization.com/civilization-5/); [Wikipedia article](https://en.wikipedia.org/wiki/Civilization_V)).

This dataset uses information organized at the [Civilization V wiki](https://civilization.fandom.com/wiki/Civilization_V) at [Fandom](https://www.fandom.com/), and that wiki is licensed under the [Creative Commons Attribution-Share Alike License](https://creativecommons.org/licenses/by-sa/3.0/).

### Repository structure
This repo's structure is inspired by https://github.com/drivendata/cookiecutter-data-science.
