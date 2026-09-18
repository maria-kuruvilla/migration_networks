# goal 
# 1 - generate a simple network with 10 vertices fully connected
# 2 - assign population sizes of animals to each vertex
# 3 - migration is possible through the network
# 4 - migration is dependent on population size
# 5 - both edges and vertices have characteristics
#     - Vertex can be vegetated, have food etc, have human habitaion
#     - Edges can have weights associated with them due to roadways, forested networks, rivers/mountains, etc


# Load necessary libraries
library(igraph)

n_vertices <- 10

migration_network_historical <- make_full_graph(n = n_vertices, directed = FALSE)

plot(migration_network_historical, 
     vertex.color = "lightblue", 
     vertex.size = 30, 
     vertex.label.color = "black", 
     edge.color = "darkgray",
     main = "Fully Connected Migration Network")

# Vertex characteristics 
V(migration_network_historical)$name <- paste0("population_",1:n_vertices)

V(migration_network_historical)$pop_size <- sample(50:500, 
                                                   size = vcount(migration_network_historical), replace = TRUE)

habitat_types <- c("Old Growth", "Wetland", "Shrubland", "Secondary Forest")


V(migration_network_historical)$habitat <- sample(habitat_types, 
                                                size = vcount(migration_network_historical), replace = TRUE)

human_presence <- c("High", "Medium", "Low", "None")

# food availability 

food_availability <- c("High", "Medium", "Low", "None")

V(migration_network_historical)$food_availability <- sample(food_availability, 
       size = vcount(migration_network_historical), replace = TRUE, 
       prob = c(0.3, 0.4, 0.2, 0.1))





V(migration_network_historical)$human_presence <- sample(human_presence, 
       size = vcount(migration_network_historical), replace = TRUE, 
       prob = c(0.2, 0.3, 0.3, 0.2))

corridor_types <- c("Dense Forest", "Open Woodland", "River Crossing", "Highway Obstruction")

E(migration_network_historical)$corridor_type <- sample(corridor_types, 
                                        size = ecount(migration_network_historical), 
                                        replace = TRUE,
                                        prob = c(0.3, 0.4, 0.15, 0.15))


weight_lookup <- c(
  "Dense Forest"        = 0.9,
  "Open Woodland"       = 0.7,
  "River Crossing"      = 0.3,
  "Highway Obstruction" = 0.1
)

E(migration_network_historical)$weight <- weight_lookup[E(migration_network_historical)$corridor_type]

#visualize the network
# Map habitat types to distinct colors
habitat_colors <- c(
  "Old Growth"       = "#2e7d32",
  "Secondary Forest" = "#81c784",
  "Wetland"          = "#0288d1",
  "Shrubland"        = "#fbc02d"
)
V(migration_network_historical)$color <- habitat_colors[V(migration_network_historical)$habitat]

#plot
plot(migration_network_historical, 
     vertex.label.cex = 0.8,
     vertex.label.color = "black",
     vertex.size = V(migration_network_historical)$pop_size/20,
     edge.width = E(migration_network_historical)$weight*5
     )


