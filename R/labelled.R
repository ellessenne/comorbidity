#' @keywords internal
.labelled <- function(x, score) {
  attr(x, "variable.labels") <- if (score == "charlson") {
    c("ID", "Myocardial infarction", "Congestive heart failure", "Peripheral vascular disease", "Cerebrovascular disease", "Dementia", "Chronic obstructive pulmonary disease", "Rheumatoid disease", "Peptic ulcer disease", "Mild liver disease", "Diabetes without chronic complications", "Diabetes with chronic complications", "Hemiplegia or paraplegia", "Renal disease", "Cancer (any malignancy)", "Moderate or severe liver disease", "Metastatic solid tumour", "AIDS/HIV", "Charlson score", "Charlson index", "Weighted Charlson score", "Weighted Charlson index")
  } else {
    c("ID", "Congestive heart failure", "Cardiac arrhythmias", "Valvular disease", "Pulmonary circulation disorders", "Peripheral vascular disorders", "Hypertension, uncomplicated", "Hypertension, complicated", "Paralysis", "Other neurological disorders", "Chronic pulmonary disease", "Diabetes, uncomplicated", "Diabetes, complicated", "Hypothyroidism", "Renal failure", "Liver disease", "Peptic ulcer disease excluding bleeding", "AIDS/HIV", "Lymphoma", "Metastatic cancer", "Solid tumour without metastasis", "Rheumatoid artritis/collaged vascular disease", "Coagulopathy", "Obesity", "Weight loss", "Fluid and electrolyte disorders", "Blood loss anaemia", "Deficiency anaemia", "Alcohol abuse", "Drug abuse", "Psychoses", "Depression", "Elixhauser score", "Elixhauser index", "Weighted Elixhauser score", "Weighted Elixhauser index")
  }
  return(x)
}
