# technology_graph.R
# This script creates a graph object out of the Civ V tech tree, suitable
# for graph statistics and visualization.

require(tidyverse)
require(tidygraph)
require(ggraph)

technology = read_csv("../../data/raw/technology.csv")
buildable = read_csv("../../data/raw/buildable.csv")
technology_dependency = read_csv("../../data/raw/technologyDependency.csv")

technology_graph = technology_dependency %>%
  inner_join(technology %>% rename(to = name), by = "technologyID") %>%
  inner_join(technology %>% rename(from = name),
             by = c("dependsOnTechnologyID" = "technologyID")) %>%
  select(from, to)

buildable_graph = buildable %>%
  filter(!is.na(dependsOnBuildableID)) %>%
  inner_join(buildable %>% rename(from = name),
             by = c("dependsOnBuildableID" = "buildableID")) %>%
  select(to = name, from)

technology_buildable_graph = buildable %>%
  filter(!is.na(dependsOnTechnologyID)) %>%
  inner_join(technology %>% rename(from = name),
             by = c("dependsOnTechnologyID" = "technologyID")) %>%
  select(to = name, from)

graph_data = technology_graph %>%
  bind_rows(buildable_graph) %>%
  bind_rows(technology_buildable_graph)
graph_data_dense = graph_data %>%
  select(from = to, to = from)  # we want direction of centrality importance
                                # to flow backwards in time

graph_tbl = as_tbl_graph(graph_data_dense)
graph_tbl_with_metrics = graph_tbl %>%
  activate(nodes) %>%
  mutate(
    pagerank = centrality_pagerank(),
    eigen = centrality_eigen(),
    community_infomap = as.factor(group_infomap())
  )
eigen = data.frame(centrality = graph_tbl_with_metrics %>% activate(nodes) %>% pull(eigen))
eigen$y = rnorm(nrow(eigen))
ggplot(eigen, aes(centrality, y, label = rownames(eigen))) +
  geom_point() + geom_text(angle = 45)

ggraph(graph_tbl_with_metrics, layout = 'kk') +
  geom_edge_link() +
  geom_node_text(aes(label = name, color = community_infomap, size = pagerank + 1)) +
  theme_graph() +
  theme(legend.position = "none")
