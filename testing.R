### R script for testing

## Load libraries
devtools::load_all()

set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  stringsAsFactors = FALSE
)

# Charlson score based on ICD-10 diagnostic codes:
xx <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10", assign0 = FALSE)
class(xx)
score(xx)

asd <- as.matrix(xx[, names(maps[[attr(xx, "map")]])])
rownames(asd) <- xx$id
vw <- matrix(
  data = c(chf = 3, carit = 4, valv = 5, pcd = 2, pvd = 4, hypunc = 1, hypc = 3, para = 2, ond = 3, cpd = 5, diabunc = 2, diabc = 2, hypothy = 4, rf = 4, ld = 3, pud = 5, aids = 3, lymph = 3, metacanc = 2, solidtum = 2, rheumd = 1, coag = 2, obes = 2, wloss = 4, fed = 4, blane = 1, dane = 3, alcohol = 3, drug = 3, psycho = 2, depre = 3),
  ncol = 1
)

asd %*% vw
# this looks good.
# how to deal with 'assign0' here though?
