# religiousBelief.csv documentation

This file describes beliefs that a civilization may choose after earning enough faith for a pantheon or starting a religion.

## Fields
1. religiousBeliefID: integer, primary key, unique.
1. name: string, not nullable.
1. classification: string from set [Pantheon, Founder Belief, Follower Belief, Enhancer Belief, Reformation Belief], not nullable.