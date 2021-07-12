# Empty list
.weights <- list()

for (w in names(.maps)) {
  if (grepl(pattern = "charlson", x = w)) {
    # Charlson-compatible weights:
    # Original Charlson weights
    .weights[[w]][["charlson"]] <- c(ami = 1, chf = 1, pvd = 1, cevd = 1, dementia = 1, copd = 1, rheumd = 1, pud = 1, mld = 1, diab = 1, diabwc = 2, hp = 2, rend = 2, canc = 2, msld = 3, metacanc = 6, aids = 6)
    # Quan (2011)
    .weights[[w]][["quan"]] <- c(ami = 0, chf = 2, pvd = 0, cevd = 0, dementia = 2, copd = 1, rheumd = 1, pud = 0, mld = 2, diab = 0, diabwc = 1, hp = 2, rend = 1, canc = 2, msld = 4, metacanc = 6, aids = 2)
  } else {
    # Elixhauser-compatible weights:
    # van Walraven
    .weights[[w]][["vw"]] <- c(chf = 7, carit = 5, valv = -1, pcd = 4, pvd = 2, hypunc = 0, hypc = 0, para = 7, ond = 6, cpd = 3, diabunc = 0, diabc = 0, hypothy = 0, rf = 5, ld = 11, pud = 0, aids = 0, lymph = 9, metacanc = 12, solidtum = 4, rheumd = 0, coag = 3, obes = -4, wloss = 6, fed = 5, blane = -2, dane = -2, alcohol = 0, drug = -7, psycho = 0, depre = -3)
    # Swiss weights
    .weights[[w]][["swiss"]] <- c(chf = 13, carit = 6, valv = -1, pcd = 6, pvd = 3, hypunc = -4, hypc = -3, para = 11, ond = 10, cpd = 3, diabunc = 1, diabc = -1, hypothy = -3, rf = 8, ld = 16, pud = 0, aids = 0, lymph = 9, metacanc = 17, solidtum = 10, rheumd = -1, coag = 9, obes = -6, wloss = 6, fed = 5, blane = -5, dane = -7, alcohol = -3, drug = -5, psycho = -4, depre = -3)
  }
  usethis::ui_done(x = "Done with score: '{w}'!")
}
