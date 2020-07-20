# technology_graph.R
# This script creates a graph object out of the Civ V tech tree, suitable
# for graph statistics and visualization.

require(tidyverse)
require(tidygraph)
require(ggraph)

civilization = read_csv("../../data/raw/civilization.csv")
era = read_csv("../../data/raw/era.csv")
great_work = read_csv("../../data/raw/greatWork.csv")

# buildable
buildable = read_csv("../../data/raw/buildable.csv")
buildable_effect_value = read_csv("../../data/raw/buildableEffectValue.csv")
buildable_action_dependency = read_csv("../../data/raw/buildableActionDependency.csv")
buildable_great_work_slots = read_csv("../../data/raw/buildableGreatWorkSlots.csv")

# technology
technology = read_csv("../../data/raw/technology.csv")
technology_dependency = read_csv("../../data/raw/technologyDependency.csv")

# terrain
terrain = read_csv("../../data/raw/terrain.csv")
terrain_improvement = read_csv("../../data/raw/terrainImprovement.csv")
terrain_resource_value = read_csv("../../data/raw/terrainResourceValue.csv")
terrain_base_classification = read_csv("../../data/raw/terrainBaseClassification.csv")
terrain_feature_classification = read_csv("../../data/raw/terrainFeatureClassification.csv")
water_type = read_csv("../../data/raw/waterType.csv")
water_proximity = read_csv("../../data/raw/waterProximity.csv")
improvement = read_csv("../../data/raw/improvement.csv")

# resource
resource = read_csv("../../data/raw/resource.csv")
resource_improvement = read_csv("../../data/raw/resourceImprovement.csv")
resource_terrain = read_csv("../../data/raw/resourceTerrain.csv")
resource_resource_value = read_csv("../../data/raw/resourceResourceValue.csv")

# religion
religious_belief = read_csv("../../data/raw/religiousBelief.csv")

# action
action = read_csv("../../data/raw/action.csv")

# effect
effect = read_csv("../../data/raw/effect.csv")

# social policy
social_policy = read_csv("../../data/raw/socialPolicy.csv")
social_policy_dependency = read_csv("../../data/raw/socialPolicyDependency.csv")


resource_resource_value_graph = resource_resource_value %>%
  inner_join(resource %>% rename(from = name), by = c("resourceID1" = "resourceID")) %>%
  inner_join(resource %>% rename(to = name), by = c("resourceID2" = "resourceID")) %>%
  select(from, to) %>%
  bind_rows(
    resource_resource_value %>%
      filter(!is.na(dependsOnBuildableID)) %>%
      inner_join(resource %>% rename(from = name), by = c("resourceID1" = "resourceID")) %>%
      inner_join(buildable %>% rename(to = name), by = c("dependsOnBuildableID" = "buildableID")) %>%
      select(from, to)
  ) %>%
  bind_rows(
    resource_resource_value %>%
      filter(!is.na(dependsOnReligiousBeliefID)) %>%
      inner_join(resource %>% rename(from = name), by = c("resourceID1" = "resourceID")) %>%
      inner_join(religious_belief %>% rename(to = name), by = c("dependsOnReligiousBeliefID" = "religiousBeliefID")) %>%
      select(from, to)
  ) %>%
  bind_rows(
    resource_resource_value %>%
      filter(!is.na(dependsOnImprovementID)) %>%
      inner_join(resource %>% rename(from = name), by = c("resourceID1" = "resourceID")) %>%
      inner_join(improvement %>% rename(to = name), by = c("dependsOnImprovementID" = "improvementID")) %>%
      select(from, to)
  ) %>%
  bind_rows(
    resource_resource_value %>%
      filter(!is.na(dependsOnTechnologyID)) %>%
      inner_join(resource %>% rename(from = name), by = c("resourceID1" = "resourceID")) %>%
      inner_join(technology %>% rename(to = name), by = c("dependsOnTechnologyID" = "technologyID")) %>%
      select(from, to)
  )

great_work_graph = great_work %>%
  inner_join(action %>% rename(from = name), by = c("dependsOnActionID" = "actionID")) %>%
  select(from, to = name)

action_graph = action %>%
  filter(!is.na(extendsActionID)) %>%
  inner_join(action %>% rename(from = name), by = c("extendsActionID" = "actionID")) %>%
  select(from, to = name) %>%
  bind_rows(
    action %>%
      filter(!is.na(dependsOnBuildableID)) %>%
      inner_join(buildable %>% rename(from = name), by = c("dependsOnBuildableID" = "buildableID")) %>%
      select(from, to = name)
  ) %>%
  bind_rows(
    action %>%
      filter(!is.na(dependsOnTechnologyID)) %>%
      inner_join(technology %>% rename(from = name), by = c("dependsOnTechnologyID" = "technologyID")) %>%
      select(from, to = name)
  ) %>%
  bind_rows(
    action %>%
      filter(!is.na(relatesToTerrainFeatureClassificationID)) %>%
      inner_join(terrain_feature_classification %>% rename(from = name), by = c("relatesToTerrainFeatureClassificationID" = "terrainFeatureClassificationID")) %>%
      select(from, to = name)
  )

social_policy_graph = social_policy_dependency %>%
  filter(!is.na(dependsOnSocialPolicyID)) %>%
  inner_join(social_policy %>% rename(to = name), by = "socialPolicyID") %>%
  inner_join(social_policy %>% rename(from = name),
             by = c("dependsOnSocialPolicyID" = "socialPolicyID")) %>%
  select(from, to) %>%
  bind_rows(
    social_policy_dependency %>%
      filter(!is.na(dependsOnEraID)) %>%
      inner_join(social_policy %>% rename(to = name), by = "socialPolicyID") %>%
      inner_join(era %>% rename(from = name),
                 by = c("dependsOnEraID" = "eraID")) %>%
      select(from, to)
  )

terrain_resource_value_graph = terrain_resource_value %>%
  inner_join(terrain %>% rename(from = name), by = "terrainID") %>%
  inner_join(resource %>% rename(to = name), by = "resourceID") %>%
  select(from, to) %>%
  bind_rows(
    terrain_resource_value %>%
      filter(!is.na(dependsOnBuildableID)) %>%
      inner_join(terrain %>% rename(from = name), by = "terrainID") %>%
      inner_join(buildable %>% rename(to = name),
                 by = c("dependsOnBuildableID" = "buildableID")) %>%
      select(from, to)
  ) %>%
  bind_rows(
    terrain_resource_value %>%
      filter(!is.na(disallowedWithCivilizationID)) %>%
      inner_join(terrain %>% rename(from = name), by = "terrainID") %>%
      inner_join(civilization %>% rename(to = name),
                 by = c("disallowedWithCivilizationID" = "civilizationID")) %>%
      select(from, to)
  )

buildable_action_graph = buildable_action_dependency %>%
  inner_join(buildable %>% rename(from = name), by = "buildableID") %>%
  inner_join(action %>% rename(to = name), by = "actionID") %>%
  select(from, to)

buildable_great_work_graph = buildable_great_work_slots %>%
  inner_join(buildable %>% rename(from = name), by = "buildableID") %>%
  inner_join(great_work %>% rename(to = name), by = "greatWorkID") %>%
  select(from, to)

technology_graph = technology_dependency %>%
  inner_join(technology %>% rename(to = name), by = "technologyID") %>%
  inner_join(technology %>% rename(from = name),
             by = c("dependsOnTechnologyID" = "technologyID")) %>%
  select(from, to)

resource_graph = resource %>%
  inner_join(technology %>% rename(from = name),
             by = c("visibleWithTechnologyID" = "technologyID")) %>%
  select(from, to = name)

terrain_graph = terrain %>%
  filter(!is.na(waterTypeID)) %>%
  inner_join(water_type %>% rename(from = name), by = "waterTypeID") %>%
  select(from, to = name) %>%
  bind_rows(
    terrain %>%
      filter(!is.na(waterProximityID)) %>%
      inner_join(water_proximity %>% rename(from = name), by = "waterProximityID") %>%
      select(from, to = name)
  ) %>%
  bind_rows(
    terrain %>%
      inner_join(terrain_base_classification %>% rename(from = name), by = "terrainBaseClassificationID") %>%
      select(from, to = name)
  ) %>%
  bind_rows(
    terrain %>%
      inner_join(terrain_feature_classification %>% rename(from = name), by = "terrainFeatureClassificationID") %>%
      select(from, to = name)
  )

resource_improvement_graph = resource_improvement %>%
  inner_join(resource %>% rename(to = name), by = "resourceID") %>%
  inner_join(improvement %>% rename(from = name), by = "improvementID") %>%
  select(from, to)

terrain_improvement_graph = terrain_improvement %>%
  inner_join(terrain %>% rename(to = name), by = "terrainID") %>%
  inner_join(improvement %>% rename(from = name), by = "improvementID") %>%
  select(from, to)

resource_terrain_graph = resource_terrain %>%
  inner_join(resource %>% rename(to = name), by = "resourceID") %>%
  inner_join(terrain %>% rename(from = name), by = "terrainID") %>%
  select(from, to)

civilization_graph = civilization %>%
  inner_join(buildable %>%
               filter(!is.na(uniqueToCivilizationID)) %>%
               rename(to = name),
             by = c("civilizationID" = "uniqueToCivilizationID")) %>%
  select(from = name, to) %>%
  bind_rows(
    civilization %>%
      inner_join(improvement %>%
                   filter(!is.na(uniqueToCivilizationID)) %>%
                   rename(to = name),
                 by = c("civilizationID" = "uniqueToCivilizationID")) %>%
      select(from = name, to)
  ) %>%
  bind_rows(
    civilization %>%
      inner_join(resource %>%
                   filter(!is.na(uniqueToCivilizationID)) %>%
                   rename(to = name),
                 by = c("civilizationID" = "uniqueToCivilizationID")) %>%
      select(from = name, to)
  )

buildable_graph = buildable %>%
  filter(!is.na(dependsOnBuildableID)) %>%
  inner_join(buildable %>% rename(from = name),
             by = c("dependsOnBuildableID" = "buildableID")) %>%
  select(to = name, from) %>%
  bind_rows(
    buildable %>%
      filter(!is.na(replacesBuildableID)) %>%
      inner_join(buildable %>% rename(from = name),
                 by = c("replacesBuildableID" = "buildableID")) %>%
      select(to = name, from)
  )

unit_upgrade_graph = buildable %>%
  filter(!is.na(upgradesToBuildableID)) %>%
  inner_join(buildable %>% rename(to = name),
             by = c("upgradesToBuildableID" = "buildableID")) %>%
  select(from = name, to) %>%
  bind_rows(
    buildable %>%
      filter(!is.na(ancientRuinsUpgradeToBuildableID)) %>%
      inner_join(buildable %>% rename(to = name),
                 by = c("ancientRuinsUpgradeToBuildableID" = "buildableID")) %>%
      select(from = name, to)
  )

buildable_effect_value_graph = buildable_effect_value %>%
  inner_join(buildable %>% rename(from = name),
             by = c("buildableID" = "buildableID")) %>%
  inner_join(buildable %>% rename(to = name),
             by = c("effectBuildableID" = "buildableID")) %>%
  select(to, from)

improvement_graph = improvement %>%
  inner_join(buildable %>% rename(from = name),
             by = c("improvedByBuildableID" = "buildableID")) %>%
  select(to = name, from) %>%
  bind_rows(
    improvement %>%
      filter(!is.na(dependsOnTechnologyID)) %>%
      inner_join(technology %>% rename(from = name),
                 by = c("dependsOnTechnologyID" = "technologyID")) %>%
      select(to = name, from)
  ) %>%
  bind_rows(
    improvement %>%
      inner_join(action %>% rename(from = name),
                 by = c("improvedByActionID" = "actionID")) %>%
      select(to = name, from)
  ) %>%
  bind_rows(
    improvement %>%
      filter(!is.na(mayRequireActionID)) %>%
      inner_join(action %>% rename(from = name),
                 by = c("mayRequireActionID" = "actionID")) %>%
      select(to = name, from)
  ) %>%
  bind_rows(
    improvement %>%
      filter(!is.na(uniqueToCivilizationID)) %>%
      inner_join(civilization %>% rename(from = name),
                 by = c("uniqueToCivilizationID" = "civilizationID")) %>%
      select(to = name, from)
  )

technology_buildable_graph = buildable %>%
  filter(!is.na(dependsOnTechnologyID)) %>%
  inner_join(technology %>% rename(from = name),
             by = c("dependsOnTechnologyID" = "technologyID")) %>%
  select(to = name, from)

technology_resource_graph = resource %>%
  filter(!is.na(visibleWithTechnologyID)) %>%
  inner_join(technology %>% rename(from = name),
             by = c("visibleWithTechnologyID" = "technologyID")) %>%
  select(to = name, from)

buildable_resource_graph = buildable %>%
  filter(!is.na(dependsOnResourceID)) %>%
  inner_join(resource %>% rename(from = name),
             by = c("dependsOnResourceID" = "resourceID")) %>%
  select(to = name, from)

graph_data = action_graph %>%
  bind_rows(buildable_action_graph) %>%
  bind_rows(buildable_effect_value_graph) %>%
  bind_rows(buildable_great_work_graph) %>%
  bind_rows(buildable_resource_graph) %>%
  bind_rows(civilization_graph) %>%
  bind_rows(great_work_graph) %>%
  bind_rows(improvement_graph) %>%
  bind_rows(resource_graph) %>%
  bind_rows(resource_improvement_graph) %>%
  bind_rows(resource_resource_value_graph) %>%
  bind_rows(resource_terrain_graph) %>%
  bind_rows(social_policy_graph) %>%
  bind_rows(technology_buildable_graph) %>%
  bind_rows(technology_resource_graph) %>%
  bind_rows(terrain_graph) %>%
  bind_rows(terrain_improvement_graph) %>%
  bind_rows(terrain_resource_value_graph) %>%
  bind_rows(unit_upgrade_graph)
graph_data_dense = graph_data %>%
  select(from = to, to = from)  # we want direction of centrality importance
                                # to flow backwards in time

graph_tbl = as_tbl_graph(graph_data_dense)
graph_tbl_with_metrics = graph_tbl %>%
  activate(nodes) %>%
  mutate(
    pagerank = centrality_pagerank(),
    eigen = centrality_eigen(),
    betweenness = centrality_betweenness(),
    community_infomap = as.factor(group_infomap()),
    degree = centrality_degree(mode = "total"),
    is_civ = name %in% civilization$name
  ) %>%
  group_by(community_infomap) %>%
  mutate(community_size = n()) %>%
  ungroup()
centrality_scores = graph_tbl_with_metrics %>% activate(nodes) %>%
  select(eigen, pagerank, betweenness, community_infomap) %>%
  as.data.frame()
centrality_scores$name = graph_tbl_with_metrics %>% activate(nodes) %>% pull(pagerank) %>% names()
ggplot(centrality_scores %>%
         filter(eigen > 0.01 | pagerank > 0.01),
       aes(eigen, betweenness, label = name, color = community_infomap)) +
  geom_point() + geom_text(angle = 45)

# igraph_layouts <- c('star', 'circle', 'gem', 'dh', 'graphopt', 'grid', 'mds', 'randomly', 'fr', 'kk', 'drl', 'lgl')
# filter(community_infomap > 0)
ggraph(graph_tbl_with_metrics %>% filter(degree > 1),
       layout = 'fr') +   # 'fr' works well, 'stress' too
  geom_edge_link() +
  geom_node_label(aes(label = name, color = is_civ)) +
  theme_graph() +
  #facet_nodes(~community_infomap) +
  theme(legend.position = "none")
