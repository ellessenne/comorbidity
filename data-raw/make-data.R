### Clean datasets to include in the package
# Required packages:
library(readxl)
library(stringr)
library(devtools)
library(usethis)
library(haven)

########################################################################################################################
### Dataset #1: ICD-10 codes, 2009 version
# Download dataset
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10/allvalid2009(detailed%20titles%20headings).xls", destfile = "data-raw/allvalid2009.xls")

# Read data in Excel format
icd10_2009 <- readxl::read_excel(
  "data-raw/allvalid2009.xls",
  skip = 7,
  col_names = c("Status", "Code", "ICD.title")
)

# Remove lines where code contains the character "-", i.e. headers:
icd10_2009[grepl("-", icd10_2009[["Code"]]), ]
icd10_2009 <- icd10_2009[!grepl("-", icd10_2009[["Code"]]), ]

# Produce a "Code.clean" variable with no punctuation
icd10_2009[["Code.clean"]] <- stringr::str_replace_all(string = icd10_2009[["Code"]], pattern = "[^[:alnum:]]", replacement = "")

# Re-order the columns
icd10_2009 <- icd10_2009[, c(2, 4, 3, 1)]

# Convert all character columns to ASCII format
icd10_2009[["Code"]] <- iconv(icd10_2009[["Code"]], from = "UTF-8", to = "ASCII")
icd10_2009[["Code.clean"]] <- iconv(icd10_2009[["Code.clean"]], from = "UTF-8", to = "ASCII")
icd10_2009[["ICD.title"]] <- iconv(icd10_2009[["ICD.title"]], from = "UTF-8", to = "ASCII")
icd10_2009[["Status"]] <- iconv(icd10_2009[["Status"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10_2009, overwrite = TRUE)

########################################################################################################################
### Dataset #2: ICD-10 codes, 2011 version
# Download dataset
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10/allvalid2011 (detailed%20titles%20headings).xls", destfile = "data-raw/allvalid2011.xls")

# Read data in Excel format
icd10_2011 <- readxl::read_excel(
  "data-raw/allvalid2011.xls",
  skip = 7,
  col_names = c("Status", "Code", "ICD.title")
)

# Remove lines where code contains the character "-", i.e. headers:
icd10_2011[grepl("-", icd10_2011[["Code"]]), ]
icd10_2011 <- icd10_2011[!grepl("-", icd10_2011[["Code"]]), ]

# Produce a "Code.clean" variable with no punctuation
icd10_2011[["Code.clean"]] <- stringr::str_replace_all(string = icd10_2011[["Code"]], pattern = "[^[:alnum:]]", replacement = "")

# Re-order the columns
icd10_2011 <- icd10_2011[, c(2, 4, 3, 1)]

# Convert all character columns to ASCII format
icd10_2011[["Code"]] <- iconv(icd10_2011[["Code"]], from = "UTF-8", to = "ASCII")
icd10_2011[["Code.clean"]] <- iconv(icd10_2011[["Code.clean"]], from = "UTF-8", to = "ASCII")
icd10_2011[["ICD.title"]] <- iconv(icd10_2011[["ICD.title"]], from = "UTF-8", to = "ASCII")
icd10_2011[["Status"]] <- iconv(icd10_2011[["Status"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10_2011, overwrite = TRUE)

########################################################################################################################
### Dataset #3: ICD-9 codes, 2015 version
# Download dataset
download.file(url = "https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/Downloads/ICD-9-CM-v32-master-descriptions.zip", destfile = "data-raw/ICD-9-CM-v32-master-descriptions.zip")

# Unzip files
unzip("data-raw/ICD-9-CM-v32-master-descriptions.zip", exdir = "data-raw")

# Read ICD-9 diagnostic codes
icd9_2015 <- readxl::read_excel("data-raw/CMS32_DESC_LONG_SHORT_DX.xlsx", skip = 1, col_names = c("Code", "Long_description", "Short_description"))

# Convert all character columns to ASCII format
icd9_2015[["Code"]] <- iconv(icd9_2015[["Code"]], from = "UTF-8", to = "ASCII")
icd9_2015[["Long_description"]] <- iconv(icd9_2015[["Long_description"]], from = "UTF-8", to = "ASCII")
icd9_2015[["Short_description"]] <- iconv(icd9_2015[["Short_description"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd9_2015, overwrite = TRUE)

########################################################################################################################
### Dataset #4 ICD-10-CM codes, 2018 version
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2018/2018-ICD-10-CM-Codes-File.zip", destfile = "data-raw/2018-ICD-10-CM-Codes-File.zip")

# Unzip files
unzip("data-raw/2018-ICD-10-CM-Codes-File.zip", exdir = "data-raw")

# Read files
icd10cm_2018 <- readr::read_tsv(file = "data-raw/icd10cm_codes_2018.txt", col_names = FALSE)
icd10cm_2018[["Code"]] <- substr(icd10cm_2018[[1]], 1, 7)
icd10cm_2018[["Description"]] <- substr(icd10cm_2018[[1]], 9, 400)
icd10cm_2018[[1]] <- NULL

# Convert all character columns to ASCII format
icd10cm_2018[["Code"]] <- iconv(icd10cm_2018[["Code"]], from = "UTF-8", to = "ASCII")
icd10cm_2018[["Description"]] <- iconv(icd10cm_2018[["Description"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10cm_2018, overwrite = TRUE)

########################################################################################################################
### Dataset #5 ICD-10-CM codes, 2017 version
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2017/icd10cm_codes_2017.txt", destfile = "data-raw/icd10cm_codes_2017.txt")

# Read files
icd10cm_2017 <- readr::read_tsv(file = "data-raw/icd10cm_codes_2017.txt", col_names = FALSE)
icd10cm_2017[["Code"]] <- substr(icd10cm_2017[[1]], 1, 7)
icd10cm_2017[["Description"]] <- substr(icd10cm_2017[[1]], 9, 400)
icd10cm_2017[[1]] <- NULL

# Convert all character columns to ASCII format
icd10cm_2017[["Code"]] <- iconv(icd10cm_2017[["Code"]], from = "UTF-8", to = "ASCII")
icd10cm_2017[["Description"]] <- iconv(icd10cm_2017[["Description"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10cm_2017, overwrite = TRUE)

########################################################################################################################
### Dataset #6: Adult same-day discharges, 2010 (from Stata)
nhds2010 <- haven::read_dta("https://www.stata-press.com/data/r15/nhds2010.dta")
attr(nhds2010, "spec") <- NULL
nhds2010 <- labelled::remove_labels(nhds2010, user_na_to_na = TRUE)

# Save data in R format
usethis::use_data(nhds2010, overwrite = TRUE)

########################################################################################################################
### Dataset #7: Australian mortality data, 2010 (from Stata)
australia10 <- haven::read_dta("https://www.stata-press.com/data/r15/australia10.dta")
attr(australia10, "spec") <- NULL
australia10 <- labelled::remove_labels(australia10, user_na_to_na = TRUE)

# Save data in R format
usethis::use_data(australia10, overwrite = TRUE)

########################################################################################################################
### Remove unnecessary files
lf <- list.files(path = "data-raw", full.names = TRUE, pattern = ".xls|.txt|.zip|.pdf")
invisible(file.remove(lf))

########################################################################################################################
### Internal Dataset #1: List of regex patterns
# Empty list
lofregex <- list()

# Charlson score, ICD9
lofregex[["charlson"]] <- list()
lofregex[["charlson"]][["icd9"]] <- list()
lofregex[["charlson"]][["icd9"]][["ami"]] <- "^410|^412"
lofregex[["charlson"]][["icd9"]][["chf"]] <- "^39891|^40201|^40211|^40291|^40401|^40403|^40411|^40413|^40491|^40493|^4254|^4255|^4256|^4257|^4258|^4259|^428"
lofregex[["charlson"]][["icd9"]][["pvd"]] <- "^0930|^4373|^440|^441|^4431|^4432|^4433|^4434|^4435|^4436|^4437|^4438|^4439|^4471|^5571|^5579|^V434"
lofregex[["charlson"]][["icd9"]][["cevd"]] <- "^36234|^430|^431|^432|^433|^434|^435|^436|^437|^438"
lofregex[["charlson"]][["icd9"]][["dementia"]] <- "^290|^2941|^3312"
lofregex[["charlson"]][["icd9"]][["copd"]] <- "^4168|^4169|^490|^491|^492|^493|^494|^495|^496|^497|^498|^499|^500|^501|^502|^503|^504|^505|^5064|^5081|^5088"
lofregex[["charlson"]][["icd9"]][["rheumd"]] <- "^4465|^7100|^7101|^7102|^7103|^7104|^7140|^7141|^7142|^7148|^725"
lofregex[["charlson"]][["icd9"]][["pud"]] <- "^531|^532|^533|^534"
lofregex[["charlson"]][["icd9"]][["mld"]] <- "^07022|^07023|^07032|^07033|^07044|^07054|^0706|^0709|^570|^571|^5733|^5734|^5738|^5739|^V427"
lofregex[["charlson"]][["icd9"]][["diab"]] <- "^2500|^2501|^2502|^2503|^2508|^2509"
lofregex[["charlson"]][["icd9"]][["diabwc"]] <- "^2504|^2505|^2506|^2507"
lofregex[["charlson"]][["icd9"]][["hp"]] <- "^3341|^342|^343|^3440|^3441|^3442|^3443|^3444|^3445|^3446|^3449"
lofregex[["charlson"]][["icd9"]][["rend"]] <- "^40301|^40311|^40391|^40402|^40403|^40412|^40413|^40492|^40493|^582|^5830|^5831|^5832|^5833|^5834|^5835|^5836|^5837|^585|^586|^5880|^V420|^V451|^V56"
lofregex[["charlson"]][["icd9"]][["canc"]] <- "^140|^141|^142|^143|^144|^145|^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|^159|^160|^161|^162|^163|^164|^165|^166|^167|^168|^169|^170|^171|^172|^174|^175|^176|^177|^178|^179|^180|^181|^182|^183|^184|^185|^186|^187|^188|^189|^190|^191|^192|^193|^194|^195|^200|^201|^202|^203|^204|^205|^206|^207|^208|^2386"
lofregex[["charlson"]][["icd9"]][["msld"]] <- "^4560|^4561|^4562|^5722|^5723|^5724|^5725|^5726|^5727|^5728"
lofregex[["charlson"]][["icd9"]][["metacanc"]] <- "^196|^197|^198|^199"
lofregex[["charlson"]][["icd9"]][["aids"]] <- "^042|^043|^044"

# Charlson score, ICD10
lofregex[["charlson"]][["icd10"]] <- list()
lofregex[["charlson"]][["icd10"]][["ami"]] <- "^I21|^I22|^I252"
lofregex[["charlson"]][["icd10"]][["chf"]] <- "^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290"
lofregex[["charlson"]][["icd10"]][["pvd"]] <- "^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959"
lofregex[["charlson"]][["icd10"]][["cevd"]] <- "^G45|^G46|^H340|^I60|^I61|^I62|^I63|^I64|^I65|^I66|^I67|^I68|^I69"
lofregex[["charlson"]][["icd10"]][["dementia"]] <- "^F00|^F01|^F02|^F03|^F051|^G30|^G311"
lofregex[["charlson"]][["icd10"]][["copd"]] <- "^I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703"
lofregex[["charlson"]][["icd10"]][["rheumd"]] <- "^M05|^M06|^M315|^M32|^M33|^M34|^M351|^M353|^M360"
lofregex[["charlson"]][["icd10"]][["pud"]] <- "^K25|^K26|^K27|^K28"
lofregex[["charlson"]][["icd10"]][["mld"]] <- "^B18|^K700|^K701|^K702|^K703|^K709|^K713|^K714|^K715|^K717|^K73|^K74|^K760|^K762|^K763|^K764|^K768|^K769|^Z944"
lofregex[["charlson"]][["icd10"]][["diab"]] <- "^E100|^E101|^E106|^E108|^E109|^E110|^E111|^E116|^E118|^E119|^E120|^E121|^E126|^E128|^E129|^E130|^E131|^E136|^E138|^E139|^E140|^E141|^E146|^E148|^E149"
lofregex[["charlson"]][["icd10"]][["diabwc"]] <- "^E102|^E103|^E104|^E105|^E107|^E112|^E113|^E114|^E115|^E117|^E122|^E123|^E124|^E125|^E127|^E132|^E133|^E134|^E135|^E137|^E142|^E143|^E144|^E145|^E147"
lofregex[["charlson"]][["icd10"]][["hp"]] <- "^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839"
lofregex[["charlson"]][["icd10"]][["rend"]] <- "^I120|^I131|^N032|^N033|^N034|^N035|^N036|^N037|^N052|^N053|^N054|^N055|^N056|^N057|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992"
lofregex[["charlson"]][["icd10"]][["canc"]] <- "^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C81|^C82|^C83|^C84|^C85|^C88|^C90|^C91|^C92|^C93|^C94|^C95|^C96|^C97"
lofregex[["charlson"]][["icd10"]][["msld"]] <- "^I850|^I859|^I864|^I982|^K704|^K711|^K721|^K729|^K765|^K766|^K767"
lofregex[["charlson"]][["icd10"]][["metacanc"]] <- "^C77|^C78|^C79|^C80"
lofregex[["charlson"]][["icd10"]][["aids"]] <- "^B20|^B21|^B22|^B24"

# Elixhauser score, ICD9
lofregex[["elixhauser"]] <- list()
lofregex[["elixhauser"]][["icd9"]] <- list()
lofregex[["elixhauser"]][["icd9"]][["chf"]] <- "^39891|^40201|^40211|^40291|^40401|^40403|^40411|^40413|^40491|^40493|^4254|^4255|^4256|^4257|^4258|^4259|^428"
lofregex[["elixhauser"]][["icd9"]][["carit"]] <- "^4260|^42613|^4267|^4269|^42610|^42612|^4270|^4271|^4272|^4273|^4274|^4276|^4277|^4278|^4279|^7850|^99601|^99604|^V450|^V533"
lofregex[["elixhauser"]][["icd9"]][["valv"]] <- "^0932|^394|^395|^396|^397|^424|^7463|^7464|^7465|^7466|^V422|^V433"
lofregex[["elixhauser"]][["icd9"]][["pcd"]] <- "^4150|^4151|^416|^4170|^4178|^4179"
lofregex[["elixhauser"]][["icd9"]][["pvd"]] <- "^0930|^4373|^440|^441|^4431|^4432|^4433|^4434|^4435|^4436|^4437|^4438|^4439|^4471|^5571|^5579|^V434"
lofregex[["elixhauser"]][["icd9"]][["hypunc"]] <- "^401"
lofregex[["elixhauser"]][["icd9"]][["hypc"]] <- "^402|^403|^404|^405"
lofregex[["elixhauser"]][["icd9"]][["para"]] <- "^3341|^342|^343|^3440|^3441|^3442|^3443|^3444|^3445|^3446|^3449"
lofregex[["elixhauser"]][["icd9"]][["ond"]] <- "^3319|^3320|^3321|^3334|^3335|^33392|^334|^335|^3362|^340|^341|^345|^3481|^3483|^7803|^7843"
lofregex[["elixhauser"]][["icd9"]][["cpd"]] <- "^4168|^4169|^490|^491|^492|^493|^494|^495|^496|^497|^498|^499|^500|^501|^502|^503|^504|^505|^5064|^5081|^5088"
lofregex[["elixhauser"]][["icd9"]][["diabunc"]] <- "^2500|^2501|^2502|^2503"
lofregex[["elixhauser"]][["icd9"]][["diabc"]] <- "^2504|^2505|^2506|^2507|^2508|^2509"
lofregex[["elixhauser"]][["icd9"]][["hypothy"]] <- "^2409|^243|^244|^2461|^2468"
lofregex[["elixhauser"]][["icd9"]][["rf"]] <- "^40301|^40311|^40391|^40402|^40403|^40412|^40413|^40492|^40493|^585|^586|^5880|^V420|^V451|^V56"
lofregex[["elixhauser"]][["icd9"]][["ld"]] <- "^07022|^07023|^07032|^07033|^07044|^07054|^0706|^0709|^4560|^4561|^4562|^570|^571|^5722|^5723|^5724|^5725|^5726|^5727|^5728|^5733|^5734|^5738|^5739|^V427"
lofregex[["elixhauser"]][["icd9"]][["pud"]] <- "^5317|^5319|^5327|^5329|^5337|^5339|^5347|^5349"
lofregex[["elixhauser"]][["icd9"]][["aids"]] <- "^042|^043|^044"
lofregex[["elixhauser"]][["icd9"]][["lymph"]] <- "^200|^201|^202|^2030|^2386"
lofregex[["elixhauser"]][["icd9"]][["metacanc"]] <- "^196|^197|^198|^199"
lofregex[["elixhauser"]][["icd9"]][["solidtum"]] <- "^140|^141|^142|^143|^144|^145|^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|^159|^160|^161|^162|^163|^164|^165|^166|^167|^168|^169|^170|^171|^172|^174|^175|^176|^177|^178|^179|^180|^181|^182|^183|^184|^185|^186|^187|^188|^189|^190|^191|^192|^193|^194|^195"
lofregex[["elixhauser"]][["icd9"]][["rheumd"]] <- "^446|^7010|^7100|^7101|^7102|^7103|^7104|^7108|^7109|^7112|^714|^7193|^720|^725|^7285|^72889|^72930"
lofregex[["elixhauser"]][["icd9"]][["coag"]] <- "^286|^2871|^2873|^2874|^2875"
lofregex[["elixhauser"]][["icd9"]][["obes"]] <- "^2780"
lofregex[["elixhauser"]][["icd9"]][["wloss"]] <- "^260|^261|^262|^263|^7832|^7994"
lofregex[["elixhauser"]][["icd9"]][["fed"]] <- "^2536|^276"
lofregex[["elixhauser"]][["icd9"]][["blane"]] <- "^2800"
lofregex[["elixhauser"]][["icd9"]][["dane"]] <- "^2801|^2802|^2803|^2804|^2805|^2806|^2807|^2808|^2809|^281"
lofregex[["elixhauser"]][["icd9"]][["alcohol"]] <- "^2652|^2911|^2912|^2913|^2915|^2916|^2917|^2918|^2919|^3030|^3039|^3050|^3575|^4255|^5353|^5710|^5711|^5712|^5713|^980|^V113"
lofregex[["elixhauser"]][["icd9"]][["drug"]] <- "^292|^304|^3052|^3053|^3054|^3055|^3056|^3057|^3058|^3059|^V6542"
lofregex[["elixhauser"]][["icd9"]][["psycho"]] <- "^2938|^295|^29604|^29614|^29644|^29654|^297|^298"
lofregex[["elixhauser"]][["icd9"]][["depre"]] <- "^2962|^2963|^2965|^3004|^309|^311"

# Elixhauser score, ICD10
lofregex[["elixhauser"]][["icd10"]] <- list()
lofregex[["elixhauser"]][["icd10"]][["chf"]] <- "^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290"
lofregex[["elixhauser"]][["icd10"]][["carit"]] <- "^I441|^I442|^I443|^I456|^I459|^I47|^I48|^I49|^R000|^R001|^R008|^T821|^Z450|^Z950"
lofregex[["elixhauser"]][["icd10"]][["valv"]] <- "^A520|^I05|^I06|^I07|^I08|^I091|^I098|^I34|^I35|^I36|^I37|^I38|^I39|^Q230|^Q231|^Q232|^Q233|^Z952|^Z953|^Z954"
lofregex[["elixhauser"]][["icd10"]][["pcd"]] <- "^I26|^I27|^I280|^I288|^I289"
lofregex[["elixhauser"]][["icd10"]][["pvd"]] <- "^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959"
lofregex[["elixhauser"]][["icd10"]][["hypunc"]] <- "^I10"
lofregex[["elixhauser"]][["icd10"]][["hypc"]] <- "^I11|^I12|^I13|^I15"
lofregex[["elixhauser"]][["icd10"]][["para"]] <- "^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839"
lofregex[["elixhauser"]][["icd10"]][["ond"]] <- "^G10|^G11|^G12|^G13|^G20|^G21|^G22|^G254|^G255|^G312|^G318|^G319|^G32|^G35|^G36|^G37|^G40|^G41|^G931|^G934|^R470|^R56"
lofregex[["elixhauser"]][["icd10"]][["cpd"]] <- "^I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703"
lofregex[["elixhauser"]][["icd10"]][["diabunc"]] <- "^E100|^E101|^E109|^E110|^E111|^E119|^E120|^E121|^E129|^E130|^E131|^E139|^E140|^E141|^E149"
lofregex[["elixhauser"]][["icd10"]][["diabc"]] <- "^E102|^E103|^E104|^E105|^E106|^E107|^E108|^E112|^E113|^E114|^E115|^E116|^E117|^E118|^E122|^E123|^E124|^E125|^E126|^E127|^E128|^E132|^E133|^E134|^E135|^E136|^E137|^E138|^E142|^E143|^E144|^E145|^E146|^E147|^E148"
lofregex[["elixhauser"]][["icd10"]][["hypothy"]] <- "^E00|^E01|^E02|^E03|^E890"
lofregex[["elixhauser"]][["icd10"]][["rf"]] <- "^I120|^I131|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992"
lofregex[["elixhauser"]][["icd10"]][["ld"]] <- "^B18|^I85|^I864|^I982|^K70|^K711|^K713|^K714|^K715|^K717|^K72|^K73|^K74|^K760|^K762|^K763|^K764|^K765|^K766|^K767|^K768|^K769|^Z944"
lofregex[["elixhauser"]][["icd10"]][["pud"]] <- "^K257|^K259|^K267|^K269|^K277|^K279|^K287|^K289"
lofregex[["elixhauser"]][["icd10"]][["aids"]] <- "^B20|^B21|^B22|^B24"
lofregex[["elixhauser"]][["icd10"]][["lymph"]] <- "^C81|^C82|^C83|^C84|^C85|^C88|^C96|^C900|^C902"
lofregex[["elixhauser"]][["icd10"]][["metacanc"]] <- "^C77|^C78|^C79|^C80"
lofregex[["elixhauser"]][["icd10"]][["solidtum"]] <- "^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C97"
lofregex[["elixhauser"]][["icd10"]][["rheumd"]] <- "^L940|^L941|^L943|^M05|^M06|^M08|^M120|^M123|^M30|^M310|^M311|^M312|^M313|^M32|^M33|^M34|^M35|^M45|^M461|^M468|^M469"
lofregex[["elixhauser"]][["icd10"]][["coag"]] <- "^D65|^D66|^D67|^D68|^D691|^D693|^D694|^D695|^D696"
lofregex[["elixhauser"]][["icd10"]][["obes"]] <- "^E66"
lofregex[["elixhauser"]][["icd10"]][["wloss"]] <- "^E40|^E41|^E42|^E43|^E44|^E45|^E46|^R634|^R64"
lofregex[["elixhauser"]][["icd10"]][["fed"]] <- "^E222|^E86|^E87"
lofregex[["elixhauser"]][["icd10"]][["blane"]] <- "^D500"
lofregex[["elixhauser"]][["icd10"]][["dane"]] <- "^D508|^D509|^D51|^D52|^D53"
lofregex[["elixhauser"]][["icd10"]][["alcohol"]] <- "^F10|^E52|^G621|^I426|^K292|^K700|^K703|^K709|^T51|^Z502|^Z714|^Z721"
lofregex[["elixhauser"]][["icd10"]][["drug"]] <- "^F11|^F12|^F13|^F14|^F15|^F16|^F18|^F19|^Z715|^Z722"
lofregex[["elixhauser"]][["icd10"]][["psycho"]] <- "^F20|^F22|^F23|^F24|^F25|^F28|^F29|^F302|^F312|^F315"
lofregex[["elixhauser"]][["icd10"]][["depre"]] <- "^F204|^F313|^F314|^F315|^F32|^F33|^F341|^F412|^F432"

# Get Elixhauser icd10cm_2020_1 and add to lofregex (see sourced file below for details)
source('AHRQ-Elixhauser/sas-parse/icd10cm_2020_1/get_lofregex.R')

lofregex[["elixhauser_ahrq_2020"]] <- list()
lofregex[["elixhauser_ahrq_2020"]][["icd10"]] <- icd10cm_2020_1_lofregex

########################################################################################################################
### Internal Dataset #2: List of msdrg mappings

# Mappings retrieved by parsing SAS code, see file sourced below
source('AHRQ-Elixhauser/sas-parse/icd10cm_2020_1/get_lofmsdrg.R')

########################################################################################################################
### Internal Dataset #3: Get icd10cm_2021_1 icd mappings
# Creates a list Elixhauser2021Formats with the following objects: 
# ElixhauserAHRQ2021Map, ElixhauserAHRQ2021Abbr, ElixhauserAHRQ2021Labels
source('AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/get_mappings.R')

########################################################################################################################
### Internal Dataset #4: Get icd10cm_2022_1 icd mappings
# Creates a list Elixhauser2022Formats with the following objects: 
# ElixhauserAHRQ2022Map, ElixhauserAHRQ2022Abbr, ElixhauserAHRQ2022Labels
source('AHRQ-Elixhauser/sas-parse/icd10cm_2022_1/get_mappings.R')

########################################################################################################################
# Export data as internal
usethis::use_data(lofregex, 
                  lofmsdrg, 
                  Elixhauser2021Formats, 
                  Elixhauser2022Formats,
                  internal = TRUE, overwrite = TRUE)
				  
# Clean up space
rm(list=ls())