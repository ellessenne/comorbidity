# Empty list
.weights <- list()

for (w in names(.maps)) {
  if (grepl(pattern = "charlson", x = w)) {
    # Charlson-compatible weights:
    # Original Charlson weights
    .weights[[w]][["charlson"]] <- c(
      ami = 1,
      chf = 1,
      pvd = 1,
      cevd = 1,
      dementia = 1,
      cpd = 1,
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
      cpd = 1,
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
  } else if (grepl(pattern = "m3", x = w)) {
    # m3 weights
    .weights[[w]][["m3"]] <- c(
      ami = 0.197491908,
      chf = 0.539809861,
      pvd = 0.349250005,
      aneur = 0.260195993,
      ven = 0.214050369,
      cevd = 0.097803808,
      dementia = 1.021975368,
      bd = 0.039711074,
      copd = 0.6253395,
      conntiss = 0.290446442,
      pud = 0.152986438,
      diabunc = 0.299383867,
      diabc = 0.271607393,
      para = 0.281895685,
      rend = 0.334155906,
      canccolrec = 0.372878764,
      cancbreast = 0.411891435,
      cancprost = 0.432343447,
      canclung = 1.972481401,
      canclymphleuk = 1.190108503,
      cancuppergi = 1.941498638,
      cancmela = 0.342233292,
      cancgyn = 0.70658858,
      cancoth = 1.103452294,
      metacanc = 2.468586878,
      msld = 0.474321939,
      aids = 0.452647425,
      ang = 0, #-0.082399267 
      hypunc = 0.117746303,
      carit = 0.173859876,
      pcd = 0.398432833,
      valv = 0.256577208,
      bdi = 0.086960591,
      ond = 0.564391512,
      epi = 0.594991823,
      mpnd = 0.208276284,
      mpd = 0.212789563,
      anxbd = 0.121481351,
      blood = 0.265142145,
      dane = 0.180927466,
      obes = 0.248243722,
      alcohol = 0.576907507,
      drug = 0.558979499,
      panc = 0, #-0.237983891
      endo = 0.112673001,
      utc = 0.046548658,
      tub = 0,  #-0.104290289
      bone = 0.132827597,
      osteounc = 0.083506878,
      immsys = 0.398529751,
      metab = 0.006265195,
      mentret = 1.405761403,
      cvhep = 0.569092852,
      sleep = 0.245749995,
      inear = 0.06090681,
      cinfnos = 0,  #-0.237983891
      maln = 0.331335106,
      ceye = 0.179923774,
      cdnos = 0, #-0.104225698
      intest = 0, #-0.254089697
      jsd = 0.095585857,
      # Zero weight exclusion/complication flags
      flag_comp_diab = 0, # Diabetes
      flag_exc_osteo = 0, # Osteoporosis
      flag_exc_hyp = 0 # Hypertension
    )
  } else {
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
  }
  usethis::ui_done(x = "Done with score: '{w}'!")
}
