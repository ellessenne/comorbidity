### Internal datasets
library(devtools)
library(usethis)

### Comorbidity maps
source("data-raw/make-mapping.R")

### Comorbidity weights
source("data-raw/make-weights.R")

### Export
usethis::use_data(.maps, .weights, internal = TRUE, overwrite = TRUE)
