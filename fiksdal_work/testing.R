library(devtools)
install_github("fiksdala/comorbidity")
library(comorbidity)
set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  stringsAsFactors = FALSE
)
# Charlson score based on ICD-10 diagnostic codes:
comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
# Elixhauser score based on ICD-10 diagnostic codes:
huh = comorbidity(x = x, id = "id", code = "code", score = "elixhauser_ahrq", assign0 = FALSE)



huh

x
?comorbidity
huh
huh %>%
  select(-c(pcd, pvd, hypc, para, ond, cpd, diabunc))

colnames(huh)
huh

huh[c('carit','valv')] = 100
huh[huh$solidtum==1, c('carit','valv')] = 1
huh[c('carit','valv')]

ls(test_sas_list)
huh
huh %>%
  rename(A = chf, B=carit, C=valv, D=pcd)





ls(test_sas_list)
