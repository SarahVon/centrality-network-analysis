# Network Cohesion & Centrality Project --------------------------------------

# load igraph library
library(igraph)


## Load Data -----------------------------------------------------------------

# read directed friendship data
friend_links <- read.csv(
  "teacher-friendship-adjacency.csv",
  header = TRUE,
  row.names = 1
)

# read node attributes for context and potential follow-up analysis
friend_nodes <- read.csv(
  "teacher-network-attributes.csv",
  header = TRUE,
  row.names = 1
)


## Build Network -------------------------------------------------------------

# create directed graph from the friendship adjacency matrix
friends_network <- graph_from_adjacency_matrix(
  as.matrix(friend_links),
  mode = "directed"
)


## Calculate Network Cohesion ------------------------------------------------

# calculate the number of weak components
weak_components <- components(friends_network, mode = "weak")$no

# calculate network density without self-loops
network_density <- edge_density(friends_network, loops = FALSE)

# calculate mean reciprocal distance across all node pairs
compactness <- function(graph) {
  graph_distances <- distances(graph)
  reciprocal_distances <- 1 / graph_distances
  diag(reciprocal_distances) <- NA
  reciprocal_distances[reciprocal_distances == 0] <- 0
  mean(reciprocal_distances, na.rm = TRUE)
}

network_compactness <- compactness(friends_network)

# calculate the proportion of connected dyads with reciprocal ties
network_reciprocity <- reciprocity(friends_network, mode = "ratio")

# calculate the global clustering coefficient
global_clustering <- transitivity(friends_network, type = "global")

# combine and print the cohesion results
cohesion_results <- data.frame(
  measure = c(
    "weak components",
    "density",
    "compactness",
    "dyadic reciprocity",
    "global clustering coefficient"
  ),
  value = c(
    weak_components,
    network_density,
    network_compactness,
    network_reciprocity,
    global_clustering
  )
)

print(cohesion_results)


## Calculate Centrality ------------------------------------------------------

# calculate in-degree and normalized betweenness for each actor
friends_in_degree <- degree(friends_network, mode = "in")
friends_betweenness <- betweenness(
  friends_network,
  directed = TRUE,
  normalized = TRUE
)

# combine both centrality measures into one data frame
centrality_data <- data.frame(
  actor = names(friends_in_degree),
  in_degree = as.numeric(friends_in_degree),
  betweenness = as.numeric(friends_betweenness),
  row.names = NULL
)

# identify and print the two highest-ranked actors for each measure
top_in_degree <- centrality_data[
  order(-centrality_data$in_degree),
][1:2, ]

top_betweenness <- centrality_data[
  order(-centrality_data$betweenness),
][1:2, ]

print(top_in_degree)
print(top_betweenness)


## Visualize Centrality ------------------------------------------------------

# export two versions of the network using the same layout
png(
  "centrality-network-analysis.png",
  width = 1800,
  height = 1000,
  res = 150
)

# create a side-by-side plotting grid
par(mfrow = c(1, 2), mar = c(1, 1, 3, 1))

# set seed so both plots use a comparable layout
set.seed(123)

# plot node size by in-degree
plot(
  friends_network,
  vertex.size = centrality_data$in_degree * 5,
  vertex.label = NA,
  edge.arrow.size = 0.1,
  vertex.color = "seagreen",
  edge.color = "gray40",
  main = "In-Degree Centrality"
)

# reset seed to repeat the layout
set.seed(123)

# plot node size by betweenness
plot(
  friends_network,
  vertex.size = centrality_data$betweenness * 600,
  vertex.label = NA,
  edge.arrow.size = 0.1,
  vertex.color = "seagreen",
  edge.color = "gray40",
  main = "Betweenness Centrality"
)
