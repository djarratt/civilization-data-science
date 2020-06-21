# technology_graph.R
# This script creates a graph object out of the Civ V tech tree, suitable
# for graph statistics and visualization.

require(tidyverse)
require(tidygraph)
require(ggraph)

technology = read_csv("../../data/raw/technology.csv")
technology_dependency = read_csv("../../data/raw/technologyDependency.csv")

graph_data = technology_dependency %>%
  inner_join(technology %>% rename(to = name), by = "technologyID") %>%
  inner_join(technology %>% rename(from = name),
             by = c("dependsOnTechnologyID" = "technologyID")) %>%
  select(from, to)

graph_tbl = as_tbl_graph(graph_data)
graph_tbl_with_metrics = graph_tbl %>%
  activate(nodes) %>%
  mutate(
    pagerank = centrality_pagerank(),
    eigen = centrality_eigen(),
    community_infomap = as.factor(group_infomap())
  )

ggraph(graph_tbl_with_metrics, layout = 'auto') +
  geom_edge_link() +
  geom_node_text(aes(label = name, color = community_infomap)) +
  scale_size_continuous(guide = 'legend') +
  theme_graph()
