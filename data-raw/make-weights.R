# Empty list
.weights <- list()

for (w in c(names(.maps), "elixhauser_ahrq_2022")) {
  if (grepl(pattern = "charlson", x = w)) {
    # Charlson-compatible weights:
    # Original Charlson weights
    .weights[[w]][["charlson"]] <- c(
      ami = 1,
      chf = 1,
      pvd = 1,
      cevd = 1,
      dementia = 1,
      copd = 1,
      rheumd = 1,
      pud = 1,
      mld = 1,
      diab = 1,
      diabwc = 2,
      hp = 2,
      rend = 2,
      canc = 2,
      msld = 3,
      metacanc = 6,
      aids = 6
    )
    # Quan (2011)
    .weights[[w]][["quan"]] <- c(
      ami = 0,
      chf = 2,
      pvd = 0,
      cevd = 0,
      dementia = 2,
      copd = 1,
      rheumd = 1,
      pud = 0,
      mld = 2,
      diab = 0,
      diabwc = 1,
      hp = 2,
      rend = 1,
      canc = 2,
      msld = 4,
      metacanc = 6,
      aids = 4
    )
  } else if (grepl(pattern = "elixhauser_icd", x = w)) {
    # Elixhauser-compatible weights:
    # van Walraven
    .weights[[w]][["vw"]] <- c(
      chf = 7,
      carit = 5,
      valv = -1,
      pcd = 4,
      pvd = 2,
      hypunc = 0,
      hypc = 0,
      para = 7,
      ond = 6,
      cpd = 3,
      diabunc = 0,
      diabc = 0,
      hypothy = 0,
      rf = 5,
      ld = 11,
      pud = 0,
      aids = 0,
      lymph = 9,
      metacanc = 12,
      solidtum = 4,
      rheumd = 0,
      coag = 3,
      obes = -4,
      wloss = 6,
      fed = 5,
      blane = -2,
      dane = -2,
      alcohol = 0,
      drug = -7,
      psycho = 0,
      depre = -3
    )
    # Swiss weights
    .weights[[w]][["swiss"]] <- c(
      chf = 13,
      carit = 6,
      valv = -1,
      pcd = 6,
      pvd = 3,
      hypunc = -4,
      hypc = -3,
      para = 11,
      ond = 10,
      cpd = 3,
      diabunc = 1,
      diabc = -1,
      hypothy = -3,
      rf = 8,
      ld = 16,
      pud = 0,
      aids = 0,
      lymph = 9,
      metacanc = 17,
      solidtum = 10,
      rheumd = -1,
      coag = 9,
      obes = -6,
      wloss = 6,
      fed = 5,
      blane = -5,
      dane = -7,
      alcohol = -3,
      drug = -5,
      psycho = -4,
      depre = -3
    )
  } else {

    #***********************************************
    #  Weights for calculating readmission index
    #***********************************************

    .weights[["elixhauser_ahrq_2022"]][["rw"]] <- c(
      AIDS         =  5,
      ALCOHOL      =  3,
      ANEMDEF      =  5,
      AUTOIMMUNE   =  2,
      BLDLOSS      =  2,
      CANCER_LEUK  = 10,
      CANCER_LYMPH =  7,
      CANCER_METS  = 11,
      CANCER_NSITU =  0,
      CANCER_SOLID =  7,
      CBVD         =  0,
      COAG         =  3,
      DEMENTIA     =  1,
      DEPRESS      =  2,
      DIAB_CX      =  4,
      DIAB_UNCX    =  0,
      DRUG_ABUSE   =  6,
      HF           =  7,
      HTN_CX       =  0,
      HTN_UNCX     =  0,
      LIVER_MLD    =  3,
      LIVER_SEV    = 10,
      LUNG_CHRONIC =  4,
      NEURO_MOVT   =  1,
      NEURO_OTH    =  2,
      NEURO_SEIZ   =  5,
      OBESE        = -2,
      PARALYSIS    =  3,
      PERIVASC     =  1,
      PSYCHOSES    =  6,
      PULMCIRC     =  3,
      RENLFL_MOD   =  4,
      RENLFL_SEV   =  8,
      THYROID_HYPO =  0,
      THYROID_OTH  =  0,
      ULCER_PEPTIC =  2,
      VALVE        =  0,
      WGHTLOSS     =  6
    )

    #*********************************************
    #  Weights for calculating mortality index
    #*********************************************

    .weights[["elixhauser_ahrq_2022"]][["mw"]] <- c(
      AIDS         = -4,
      ALCOHOL      = -1,
      ANEMDEF      = -3,
      AUTOIMMUNE   = -1,
      BLDLOSS      = -4,
      CANCER_LEUK  =  9,
      CANCER_LYMPH =  6,
      CANCER_METS  = 23,
      CANCER_NSITU =  0,
      CANCER_SOLID = 10,
      CBVD         =  5,
      COAG         = 15,
      DEMENTIA     =  5,
      DEPRESS      = -9,
      DIAB_CX      = -2,
      DIAB_UNCX    =  0,
      DRUG_ABUSE   = -7,
      HF           = 15,
      HTN_CX       =  1,
      HTN_UNCX     =  0,
      LIVER_MLD    =  2,
      LIVER_SEV    = 17,
      LUNG_CHRONIC =  2,
      NEURO_MOVT   = -1,
      NEURO_OTH    = 23,
      NEURO_SEIZ   =  2,
      OBESE        = -7,
      PARALYSIS    =  4,
      PERIVASC     =  3,
      PSYCHOSES    = -9,
      PULMCIRC     =  4,
      RENLFL_MOD   =  3,
      RENLFL_SEV   =  8,
      THYROID_HYPO = -3,
      THYROID_OTH  = -8,
      ULCER_PEPTIC =  0,
      VALVE        =  0,
      WGHTLOSS     = 14
    )

  }
  usethis::ui_done(x = "Done with score: '{w}'!")
}
