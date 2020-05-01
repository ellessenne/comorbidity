library(tidyverse)

# SAS References:
# https://www.hcup-us.AHRQ.gov/toolssoftware/comorbidityicd10/comorbidity_icd10.jsp
# https://www.hcup-us.AHRQ.gov/toolssoftware/comorbidityicd10/comformat_icd10cm_2020_1.txt
# https://www.hcup-us.AHRQ.gov/toolssoftware/comorbidityicd10/comoanaly_icd10cm_2020_1.txt
# Both comformat_icd10cm_2020_1 and comoanaly_icd10cm_2020_1 .txt files must
# be in comorbidity/maintenance/ directory for this script to function.

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
sas_path <- "maintenance/comformat_icd10cm_2020_1.txt"
sas_AHRQ_raw <- readLines(sas_path)

# Make list of lists for AHRQ codes to compare
make_sas_list = function(sas_AHRQ_raw){
  # Assigns ICD-10 codes to comorbidty labels from sas file located here:
  # https://www.hcup-us.AHRQ.gov/toolssoftware/comorbidityicd10/comformat_icd10cm_2020_1.txt
  # Omits /**** ICD-10 MS-DRG V37 Formats ****/
  
  # Clean up readlines
  sas_AHRQ_prep <- sas_AHRQ_raw[sas_AHRQ_raw!=""] %>% # Remove empty lines
    .[-(1:18)] %>% # First 18 elements are extraneous
    lapply(function(x) str_split(x,"\\/\\*")[[1]][1] ) %>% # Drop sas comments
    unlist() %>%
    str_trim() %>% # Trim white space
    str_replace_all('\\"', "") %>% # Remove extraneous characters
    str_replace_all(',', "") # Remove extraneous characters
  
  AHRQ_list = list() # create empty list
  temp_list = c() # placeholder for codes
  for(l in sas_AHRQ_prep){
    if(grepl("=", l, fixed=T)){
      split_l = str_split(l,'=')[[1]]
      temp_list = append(temp_list, split_l[1])
      # AHRQ_list[[split_l[2]]] = str_c(temp_list, collapse="|")
      # Must have ^ so that regex doesn't search for within-code substrings
      AHRQ_list[[split_l[2]]] = paste0("^", str_c(temp_list, collapse="|^"))
      temp_list = c()
    } else {
      temp_list = append(temp_list, l)
    }
    # Omit everything after wghtloss
    if(l == "R636=WGHTLOSS"){
      break
    }
  }
  AHRQ_list # return the list
}
AHRQ_list = make_sas_list(sas_AHRQ_raw)

# Write to txt file
if (file.exists("maintenance/AHRQ_sas_conversion.txt")){
  file.remove("maintenance/AHRQ_sas_conversion.txt")
}
for (g in names(AHRQ_list)) {
  cat(paste0('lofregex[["elixhauser_ahrq"]][["icd10"]][["',
             g,'"]] <- "', sas_list[g], '"'),
      file="maintenance/AHRQ_sas_conversion.txt",sep="\n", append=T)
}

# Make lofmsdrg from comformat_icd10cm_2020_1.txt
# Helper functions to format msdrgs
convert_interval = function(interval) {
  split_interval = str_split(interval, '-')[[1]]
  if (length(split_interval)>1) {
    c(as.numeric(split_interval[1]):as.numeric(split_interval[2]))
  } else {
    as.numeric(split_interval[1])
  }
}

format_msdrg = function(x) {
  x %>%
    str_split(',') %>% # Separate intervals
    unlist() %>% # Unlist 
    str_trim() %>% # Trim whitespace
    .[.!=""] %>% # Remove blanks
    sapply(convert_interval) %>% # convert to numeric intervals
    unlist() %>% # clean up
    unname() %>% # clean up 
    as.vector() # keep consistent with vectors
}

make_lofmsdrg <- function(sas_AHRQ_raw){
  raw_msdrg = sas_AHRQ_raw[-(1:grep("ICD-10 MS-DRG V37 Formats", 
                        sas_AHRQ_raw))] # Skip to MS-DRG
  raw_msdrg = raw_msdrg[raw_msdrg!="" & 
                          raw_msdrg!="Run;" & 
                          raw_msdrg!="   "] # Drop empty and run
  raw_msdrg = str_trim(raw_msdrg)
  
  msdrg_labels = list()
  msdrg_num_unformated = c()
  for (i in raw_msdrg){
    # Get value labels
    if (grepl("VALUE", i)){
      split_label = str_split(i, 'VALUE')[[1]][[2]] %>%
        str_trim() %>%
        str_split(" ")
      msdrg_labels[[split_label[[1]][1]]] = list()
      last_value = split_label[[1]][1]
    }
    if (grepl("\\d", i[1])){ # Extract numbers
      msdrg_num_unformated = append(msdrg_num_unformated,
                                    str_split(i, ' = ')[[1]][1])
    }
    if (grepl(';', i)){ # assign formatted MS-DRGs to label
      msdrg_labels[[split_label[[1]][1]]] = format_msdrg(msdrg_num_unformated)
      msdrg_num_unformated = c() # clear MS-DRG list for next loop
    }
  }
  msdrg_labels
}
lofmsdrg = make_lofmsdrg(sas_AHRQ_raw)

# Running this script in make-data.R will allow lofregex to be updated and
# lofmsdrg to be added to sysdata.rda
