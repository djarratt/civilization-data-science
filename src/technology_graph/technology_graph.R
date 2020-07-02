# technology_graph.R
# This script creates a graph object out of the Civ V tech tree, suitable
# for graph statistics and visualization.

require(tidyverse)
require(tidygraph)
require(ggraph)
require(ggrepel)

technology = read_csv("../../data/raw/technology.csv")
buildable = read_csv("../../data/raw/buildable.csv")
effect = read_csv("../../data/raw/effect.csv")
improvement = read_csv("../../data/raw/improvement.csv")
resource = read_csv("../../data/raw/resource.csv")
terrain = read_csv("../../data/raw/terrain.csv")
civilization = read_csv("../../data/raw/civilization.csv")
technology_dependency = read_csv("../../data/raw/technologyDependency.csv")
resource_improvement = read_csv("../../data/raw/resourceImprovement.csv")
terrain_improvement = read_csv("../../data/raw/terrainImprovement.csv")
resource_terrain = read_csv("../../data/raw/resourceTerrain.csv")
water_type = read_csv("../../data/raw/waterType.csv")

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
  select(from, to = name)

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

effect_graph = effect %>%
  inner_join(buildable %>% rename(from = name),
             by = c("buildableID" = "buildableID")) %>%
  inner_join(buildable %>% rename(to = name),
             by = c("givesFreeBuildableID" = "buildableID")) %>%
  select(to, from)

improvement_graph = improvement %>%
  filter(!is.na(dependsOnTechnologyID), !is.na(improvedByBuildableID)) %>%
  inner_join(buildable %>% rename(from = name),
             by = c("improvedByBuildableID" = "buildableID")) %>%
  select(to = name, from) %>%
  bind_rows(
    improvement %>%
      filter(!is.na(dependsOnTechnologyID), !is.na(improvedByBuildableID)) %>%
      inner_join(technology %>% rename(from = name),
                 by = c("dependsOnTechnologyID" = "technologyID")) %>%
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

graph_data = technology_graph %>%
  bind_rows(buildable_graph) %>%
  bind_rows(technology_buildable_graph) %>%
  bind_rows(unit_upgrade_graph) %>%
  bind_rows(improvement_graph) %>%
  bind_rows(effect_graph) %>%
  bind_rows(technology_resource_graph) %>%
  bind_rows(buildable_resource_graph) %>%
  bind_rows(terrain_graph) %>%
  bind_rows(resource_graph) %>%
  bind_rows(resource_improvement_graph) %>%
  bind_rows(terrain_improvement_graph) %>%
  bind_rows(resource_terrain_graph) %>%
  bind_rows(civilization_graph)
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
    degree = centrality_degree(mode = "total")
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
       aes(log(eigen), log(betweenness), label = name, color = community_infomap)) +
  geom_point() + geom_text(angle = 45)

# igraph_layouts <- c('star', 'circle', 'gem', 'dh', 'graphopt', 'grid', 'mds', 'randomly', 'fr', 'kk', 'drl', 'lgl')
# filter(community_infomap > 0)
ggraph(graph_tbl_with_metrics %>% filter(degree > 2),
       layout = 'fr') +   # 'fr' works well, 'stress' too
  geom_edge_link() +
  geom_node_label(aes(label = name, color = community_infomap), repel = TRUE) +
  theme_graph() +
  #facet_nodes(~community_infomap) +
  theme(legend.position = "none")
