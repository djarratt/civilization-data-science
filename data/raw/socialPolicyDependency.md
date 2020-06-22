# socialPolicyDependency.csv documentation

This file describes the dependency chart among social policies and eras. A social policy becomes available if its requisite era is reached, or if its parent policy or policies are adopted.

## Fields
1. socialPolicyID: integer, foreign key referencing socialPolicy.csv:socialPolicyID, not nullable.
1. dependsOnSocialPolicyID: integer, foreign key referencing socialPolicy.csv:socialPolicyID, nullable.
1. dependsOnEraID: integer, foreign key referencing era.csv:eraID, nullable.