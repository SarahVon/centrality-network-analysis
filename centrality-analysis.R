# HW2: Network Cohesion & Centrality --------------------------------------

# Run this script from the repository directory; all inputs use project-relative paths.

# load igraph library
library(igraph)

# read in friend data (links)
friend_links <- read.csv("teacher-friendship-adjacency.csv", header = T, row.names = 1)

# read in attribute data (nodes)
friend_nodes <- read.csv("teacher-network-attributes.csv", header = T, row.names = 1)

# creating graph object
friends_network <- graph_from_adjacency_matrix(as.matrix(friend_links), mode = "directed")


## QUESTIONS --------------------------------------------------------------

# Question 1: Describing cohesion (typed in separate doc). 

# Question 2: Describing centrality (typed in separate doc).

# Question 3: Finding number of weak components in friends graph
components(friends_network,mode = "weak") # 8

# Question 4: Finding the density of the friends graph
edge_density(friends_network, loops = F) # 0.042

# Question 5: Finding the compactness of the network (using func from R Markdown)
compactness <- function(friends_network) {
  gra.geo <- distances(friends_network) ## generate geodesic distances
  gra.rdist <- 1/gra.geo  ## reciprocal of geodesics
  diag(gra.rdist) <- NA   ## assign NA to diagonal
  gra.rdist[gra.rdist == 0] <- 0 
  # Compactness = mean of reciprocal distances
  comp.igph <- mean(gra.rdist, na.rm=TRUE) 
  return(comp.igph)
}
compactness(friends_network)

# Question 6: Finding the dyadic reciprocity
reciprocity(friends_network, mode = c("ratio")) # 0.393

# Question 7: Finding the global clustering coefficient
transitivity(friends_network, type = "global") # 0.2

# Question 8: Interpreting each of the measures above (typed in separate doc).

# Generating the in-degree and betweeness for the graph to answer the last few questions
friends_in_degree <- degree(friends_network, mode = "in")
friends_betweenness <- betweenness(friends_network, directed = T, normalized = T)

# Create a data frame with both the centrality measures
centrality_data <- data.frame(friends_in_degree, friends_betweenness)

# Question 9: Identifying the two most central actors as measured by in-degree
centrality_data[order(-centrality_data$friends_in_degree),][1:2,]

# Question 10: Identifying the two most central actors as measured by betweenness
centrality_data[order(-centrality_data$friends_betweenness),][1:2,]

# Question 11: Explaining how the two measures can identify different central
# actors and describing which would best describe "popularity". (typed in separate doc)

# Plotting two graphs with one weighted by in-degree and the other by betweenness

# creating our grid
par(mfrow=c(1,2), mar=c(1,1,1,1))

# set seed
set.seed(123)

# plot in-degree
plot(friends_network, 
     # vertex size based on in-degree
     vertex.size = centrality_data$friends_in_degree*5, 
     # no vertex labels
     vertex.label = NA,
     # arrow size
     edge.arrow.size = 0.1, 
     # vertex color
     vertex.color = "seagreen",
     # edge color
     edge.color = "gray40",
     # title
     main = "In-Degree Centrality")

# set seed
set.seed(123)

# plot betweenness
plot(friends_network, 
     # vertex size based on betweenness
     vertex.size = centrality_data$friends_betweenness*600,
     # no vertex labels
     vertex.label = NA, 
     # arrow size
     edge.arrow.size = 0.1, 
     # vertex color
     vertex.color = "seagreen",
     # edge color
     edge.color = "gray40",
     # title
     main = "Betweenness Centrality")




