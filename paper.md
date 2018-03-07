---
title: "comorbidity: An R package for computing comorbidity scores"
tags:
- comorbidity scores
- epidemiology
- biostatistics
- ICD
- R
authors:
- name: Alessandro Gasparini
  orcid: 0000-0002-8319-7624
  affiliation: 1
affiliations:
- name: Biostatistics Research Group, Department of Health Sciences, University of Leicester
  index: 1
date: 7 March 2018
bibliography: paper.bib
---

# Summary

Comorbidity scores are used extensively in observational medical research studies to avoid potential bias when the burden of disease could be considered to be a confounder for the association of interest. This is of primary importance, given the increasing availability and use of administrative data (such as medical records and insurance claims) for research purposes. Several comorbidity scores have emerged throughout the years; however, two scores appear to be used most frequently in practice and are considered the de-facto standard choice: the Charlson comorbidity index [@Charlson_1987] and the Elixhauser comorbidity index [@Elixhauser_1998]. The Charlson comorbidity index defines a set of comorbid conditions using International Classification of Disease (ICD) diagnostic codes; each comorbidity score has an associated weight, and the sum of all weights results in a single comorbidity score per patient. The current version of the Charlson score includes 17 comorbidities. The Elixhauser comorbidity index is based on ICD diagnostic codes as well, and the current version includes 31 different comorbidities. Originally, the Elixhauser index score was based on the cumulative number of conditions present; despite that, different weighting systems have been developed and proposed since then and are in fact used in practice [@vanWalraven_2009; @Moore_2017].

`comorbidity` is an R package that allows computing comorbidity scores in an easy and straightforward way. There is a single function to estimate all the scores, named `comorbidity`, and specific scores can be selected by passing the appropriate `score` argument. Currently, the Charlson comorbidity score and the Elixhauser comorbidity score are supported, using both the ICD-9-CM and the ICD-10 coding system. The implementation is based on the coding algorithms published by Quan _et al_. in 2005 [@Quan_2005]. The weighting system implemented for the Charlson score is based on the original paper by Charlson _et al_. [@Charlson_1987]; conversely, we implemented the weighting system proposed by Moore _et al_. for the ICD-9-CM Elixhauser score [@Moore_2017] and the weighting system proposed by van Walraven _et al_. for the ICD-10 version [@vanWalraven_2009]. Each comorbidity score is coded separately and called internally by the `comorbidity` function, for maintainability purposes; as a side effect, this makes it trivial to implement additional comorbidity scores in the future. Finally, computing comorbidity scores can be time-consuming with large datasets (both in terms of number of patients and diagnostic codes). To mitigate this potential problem, parallel computing is supported out of the box with no additional programming required by the user: it is sufficient to set the argument `parallel = TRUE` when calling `comorbidity`.

# References
