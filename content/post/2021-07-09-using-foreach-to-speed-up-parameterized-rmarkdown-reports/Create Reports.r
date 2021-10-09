library(tidyverse)
library(foreach)
library(doParallel)

species_names <- as.character(unique(iris$Species))


n_cores <- parallel::detectCores()
cluster <- parallel::makeCluster(n_cores)                 
doParallel::registerDoParallel(cluster)

foreach (i = seq_along(species_names), .combine = 'c') %dopar% {
  system.time(rmarkdown::render("Report-Layout.rmd",
                    params = list(species = species_names[i]),
                    output_file = paste0("Report for ", species_names[i])))
}
