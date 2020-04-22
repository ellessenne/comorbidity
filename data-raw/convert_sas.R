library(tidyverse)
library(stringr)
# sas file downloaded from:
# https://www.hcup-us.ahrq.gov/toolssoftware/comorbidityicd10/comformat_icd10cm_2020_1.txt

# Example pattern to extract:
# "D500",
# "O9081",
# "O99011",
# "O99012",
# "O99013",
# "O99019",
# "O9902",
# "O9903"="BLDLOSS"        /*Blood loss anemia*/

# Read in data
sas_url <- "https://www.hcup-us.ahrq.gov/toolssoftware/comorbidityicd10/comformat_icd10cm_2020_1.txt"
sas_ahrq_raw <- readLines(sas_url)

# Make list of lists for ahrq codes to compare
make_sas_list = function(sas_ahrq_raw){
  # Assigns ICD-10 codes to comorbidty labels from sas file located here:
  # https://www.hcup-us.ahrq.gov/toolssoftware/comorbidityicd10/comformat_icd10cm_2020_1.txt
  # Omits /**** ICD-10 MS-DRG V37 Formats ****/
  
  # Clean up readlines
  sas_ahrq_prep <- sas_ahrq_raw[sas_ahrq_raw!=""] %>% # Remove empty lines
    .[-(1:18)] %>% # First 18 elements are extraneous
    lapply(function(x) str_split(x,"\\/\\*")[[1]][1] ) %>% # Drop sas comments
    unlist() %>%
    str_trim() %>% # Trim white space
    str_replace_all('\\"', "") %>% # Remove extraneous characters
    str_replace_all(',', "") # Remove extraneous characters
  
  ahrq_list = list() # create empty list
  temp_list = c() # placeholder for codes
  for(l in sas_ahrq_prep){
    if(grepl("=", l, fixed=T)){
      split_l = str_split(l,'=')[[1]]
      temp_list = append(temp_list, split_l[1])
      ahrq_list[[split_l[2]]] = str_c(temp_list, collapse="|")
      # ahrq_list[[split_l[2]]] = paste0("^", str_c(temp_list, collapse="|^"))
      temp_list = c()
    } else {
      temp_list = append(temp_list, l)
    }
    # Omit everything after wghtloss
    if(l == "R636=WGHTLOSS"){
      break
    }
  }
  ahrq_list # return the list
}
sas_list = make_sas_list(sas_ahrq_raw)

# Write to txt file to merge with make-data.R
if (file.exists("data/ahrq_sas_conversion.txt")){
  file.remove("data/ahrq_sas_conversion.txt")
}
for (g in names(sas_list)) {
  cat(paste0('lofregex[["elixhauser_ahrq"]][["icd10"]][["',
             g,'"]] <- "', test_sas_list[g], '"'),
      file="data/ahrq_sas_conversion.txt",sep="\n", append=T)
}
