library(comorbidity)
devtools::load_all()

set.seed(1)
N = 200
x <- data.frame(
  id = sample(1:15, size = N, replace = TRUE),
  code = sample_diag(N),
  drg = formatC(sample.int(999, N, replace=TRUE), width=3, flag="0"),
  stringsAsFactors = FALSE
)
x$drg[sample(N,floor(N*.8))] = NA # Randomly remove DRGs for testing


pre_drg = comorbidity(x = x, id = "id", code = "code", score = "elixhauser_ahrq", assign0 = FALSE, drg='drg')
pre_drg
sum(pre_drg$HTN)
floor(4.5)

compute_ahrq = function(x, id, code, score, drg) {
  # Get MS-DRG flags
  stacked_lofmsdrg = stack(lofmsdrg)
  msdrg_key_value = as.vector(stacked_lofmsdrg$ind)
  names(msdrg_key_value) = as.character(stacked_lofmsdrg$values)
  msdrg_key_value
  
  # Drop DRG leading zeros, convert to character
  all_drgs = as.numeric(x[[drg]])
  all_drgs = as.character(all_drgs)
  
  # Get list of SAS drg flags
  drg_flags = msdrg_key_value[all_drgs]
  names(drg_flags) = x[[id]]
  drg_flags = drg_flags[!is.na(drg_flags)]
  drg_flags = unstack(stack(drg_flags)) # get named list of lists
  drg_flags = lapply(drg_flags, unique)
  drg_flags
}

huh = compute_ahrq(x=x, id='id', code='icd10', score='elixhauser_ahrq',
             drg='drg')

huh
pre_drg
pre_drg[names(lofmsdrg)] = NA
for (i in names(huh)) {
  pre_drg['id'==i, huh[[i]]] = 1
}
pre_drg %>%
  ls()

######### CHECK HTN/HTNC LOGIC MANUALLY
tdf = data.frame(a=c(NA,NA,1,2,3),b=c(1,2,3,4,5))
tdf[is.na(tdf)] = 0
tdf
