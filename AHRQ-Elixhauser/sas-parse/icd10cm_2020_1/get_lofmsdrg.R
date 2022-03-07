library(stringr)

# Make lofmsdrg from comformat_icd10cm_2020_1.txt
download.file(
  url = "https://www.hcup-us.AHRQ.gov/toolssoftware/comorbidityicd10/comformat_icd10cm_2020_1.txt",
  destfile = "AHRQ-Elixhauser/sas-parse/icd10cm_2020_1/comformat_icd10cm_2020_1.txt"
)

# Read in data
sas_path <- "AHRQ-Elixhauser/sas-parse/icd10cm_2020_1/comformat_icd10cm_2020_1.txt"
sas_AHRQ_raw <- readLines(sas_path)


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
  prep <- str_trim(unlist(str_split(x, ',')))
  as.vector(
    unname(
      unlist(
        sapply(prep[prep!=""], convert_interval)
      )
    )
  )
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
      split_label = str_split(str_trim(str_split(i, 'VALUE')[[1]][[2]]), " ")
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

# Remove comformat_icd10cm_2020_1.txt
file.remove(sas_path)