### Internal datasets
library(devtools)
library(usethis)

### Comorbidity weights
source("data-raw/make-data-ahrq.R")

### Comorbidity maps
source("data-raw/make-mapping.R")

### Comorbidity weights
source("data-raw/make-weights.R")

### Remove extraneous files
all_files <- list.files('data-raw')
drop_files <- all_files[
  sapply(
    all_files,
    function(x){
      substr(
        x, 
        nchar(x) - 2 + 1, 
        nchar(x)
      ) != '.R'
    }
  )
]
sapply(
  drop_files,
  function(x){
    file.remove(
      file.path(
        'data-raw', 
        x
      )
    )
  }
)

### Export
usethis::use_data(.maps,
                  .weights,
                  lofregex,
                  lofmsdrg,
                  Elixhauser2021Formats,
                  Elixhauser2022Formats,
                  internal = TRUE, overwrite = TRUE)

### Clean up workspace
rm(list=ls())