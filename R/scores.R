#' @keywords internal
charlson_icd9 <- function(x, id, code) {
  ami <- max(grepl("^410|^412", x[[code]]))
  chf <- max(grepl("^39891|^40201|^40211|^40291|^40401|^40403|^40411|^40413|^40491|^40493|^4254|^4255|^4256|^4257|^4258|^4259|^428", x[[code]]))
  pvd <- max(grepl("^0930|^4373|^440|^441|^4431|^4432|^4433|^4434|^4435|^4436|^4437|^4438|^4439|^471|^5571|^5579|^V434", x[[code]]))
  cevd <- max(grepl("^36234|^430|^431|^432|^433|^434|^435|^436|^437|^438", x[[code]]))
  dementia <- max(grepl("^290|^2941|^3312", x[[code]]))
  copd <- max(grepl("^4168|^4169|^490|^491|^492|^493|^494|^495|^496|497|^498|^499|^500|^501|^502|^503|^504|^505|^5064|^5081|^5088", x[[code]]))
  rheumd <- max(grepl("^4465|^7100|^7101|^7102|^7103|^7104|^7140|^7141|^7142|^7148|^725", x[[code]]))
  pud <- max(grepl("^531|^532|^533|^534", x[[code]]))
  mld <- max(grepl("^07022|^07023|^07032|^07033|^07044|^07054|^0706|^0709|^570|^571|^5733|^5734|^5738|^5739|^V427", x[[code]]))
  diab <- max(grepl("^2500|^2501|^2502|^2503|^2508|^2509", x[[code]]))
  diabwc <- max(grepl("^2504|^2505|^2506|^2507", x[[code]]))
  hp <- max(grepl("^3341|^342|^343|^3440|^3441|^3442|^3443|^3444|^3445|^3446|^3449", x[[code]]))
  rend <- max(grepl("^40301|^40311|^40391|^40402|^40403|^40412|^40413|^40492|^40493|^582|^5830|^5831|^5832|^5833|^5834|^5835|^5836|^5837|^585|^586|^5880|^V420|^V451|^V56", x[[code]]))
  canc <- max(grepl("^140|^141|^142|^143|^144|^145|^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|^159|^160|^161|^162|^163|^164|^165|^166|^167|^168|^169|^170|^171|^172|^174|^175|^176|^177|^178|^179|^180|^181|^182|^183|^184|^185|^186|^187|^188|^189|^190|^191|^192|^193|^194|^195|^200|^201|^202|^203|^204|^205|^206|^207|^208|^2386", x[[code]]))
  msld <- max(grepl("^4560|^4561|^4562|^5722|^5723|^5724|^5725|^5726|^5727|^5728", x[[code]]))
  metacanc <- max(grepl("^196|^197|^198|^199", x[[code]]))
  aids <- max(grepl("^042|^043|^044", x[[code]]))
  out <- list()
  out[[id]] <- unique(x[[id]])
  out$ami <- ami
  out$chf <- chf
  out$pvd <- pvd
  out$cevd <- cevd
  out$dementia <- dementia
  out$copd <- copd
  out$rheumd <- rheumd
  out$pud <- pud
  out$mld <- mld
  out$diab <- diab
  out$diabwc <- diabwc
  out$hp <- hp
  out$rend <- rend
  out$canc <- canc
  out$msld <- msld
  out$metacanc <- metacanc
  out$aids <- aids
  out <- data.frame(out)
  return(out)
}

#' @keywords internal
charlson_icd10 <- function(x, id, code) {
  ami <- max(grepl("^I21|^I22|^I252", x[[code]]))
  chf <- max(grepl("^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290", x[[code]]))
  pvd <- max(grepl("^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959", x[[code]]))
  cevd <- max(grepl("^G45|^G46|^H340|^I60|^I61|^I62|^I63|^I64|^I65|^I66|^I67|^I68|^I69", x[[code]]))
  dementia <- max(grepl("F00|^F01|^F02|^F03|^F051|^G30|^G311", x[[code]]))
  copd <- max(grepl("I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703", x[[code]]))
  rheumd <- max(grepl("^M05|^M06|^M315|^M32|^M33|^M34|^M351|^M353|^M360", x[[code]]))
  pud <- max(grepl("^K25|^K26|^K27|^K28", x[[code]]))
  mld <- max(grepl("^B18|^K700|^K701|^K702|^K703|^K709|^K713|^K714|^K715|^K717|^K73|^K74|^K760|^K762|^K763|^K764|^K768|^K769|^Z944", x[[code]]))
  diab <- max(grepl("^E100|^E101|^E106|^E108|^E109|^E110|^E111|^E116|^E118|^E119|^E120|^E121|^E126|^E128|^E129|^E130|^E131|^E136|^E138|^E139|^E140|^E141|^E146|^E148|^E149", x[[code]]))
  diabwc <- max(grepl("^E102|^E103|^E104|^E105|^E107|^E112|^E113|^E114|^E115|^E117|^E122|^E123|^E124|^E125|^E127|^E132|^E133|^E134|^E135|^E137|^E142|^E143|^E144|^E145|^E147", x[[code]]))
  hp <- max(grepl("^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839", x[[code]]))
  rend <- max(grepl("^I120|^I131|^N032|^N033|^N034|^N035|^N036|^N037|^N052|^N053|^N054|^N055|^N056|^N057|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992", x[[code]]))
  canc <- max(grepl("^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C81|^C82|^C83|^C84|^C85|^C88|^C90|^C91|^C92|^C93|^C94|^C95|^C96|^C97", x[[code]]))
  msld <- max(grepl("^I850|^I859|^I864|^I982|^K704|^K711|^K721|^K729|^K765|^K766|^K767", x[[code]]))
  metacanc <- max(grepl("^C77|^C78|^C79|^C80", x[[code]]))
  aids <- max(grepl("^B20|^B21|^B22|^B24", x[[code]]))
  out <- list()
  out[[id]] <- unique(x[[id]])
  out$ami <- ami
  out$chf <- chf
  out$pvd <- pvd
  out$cevd <- cevd
  out$dementia <- dementia
  out$copd <- copd
  out$rheumd <- rheumd
  out$pud <- pud
  out$mld <- mld
  out$diab <- diab
  out$diabwc <- diabwc
  out$hp <- hp
  out$rend <- rend
  out$canc <- canc
  out$msld <- msld
  out$metacanc <- metacanc
  out$aids <- aids
  out <- data.frame(out)
  return(out)
}

#' @keywords internal
elixhauser_icd9 <- function(x, id, code) {
  chf <- max(grepl("^39891|^40201|^40211|^40291|^40401|^40403|^40411|^40413|^40491|^40493|^4254|^4255|^4256|^4257|^4258|^4259|^428", x[[code]]))
  carit <- max(grepl("^4260|^42613|^4267|^4269|^42610|^42612|^4270|^4271|^4272|^4273|^4274|^4276|^4277|^4278|^4279|^7850|^99601|^99604|^V450|^V533", x[[code]]))
  valv <- max(grepl("^0932|^394|^395|^396|^397|^424|^7463|^7464|^7465|^7466|^V422|^V433", x[[code]]))
  pcd <- max(grepl("^4150|^4151|^416|^4170|^4178|^4179", x[[code]]))
  pvd <- max(grepl("^0930|^4373|^440|^441|^4431|^4432|^4433|^4434|^4435|^4436|^4437|^4438|^4439|^4471|^5571|^5579|^V434", x[[code]]))
  hypunc <- max(grepl("^401", x[[code]]))
  hypc <- max(grepl("^402|^403|^404|^405", x[[code]]))
  para <- max(grepl("^3341|^342|^343|^3440|^3441|^3442|^3443|^3444|^3445|^3446|^3449", x[[code]]))
  ond <- max(grepl("^3319|^3320|^3321|^3334|^3335|^33392|^334|^335|^3362|^340|^341|^345|^3481|^3483|^7803|^7843", x[[code]]))
  cpd <- max(grepl("^4168|^4169|^490|^491|^492|^493|^494|^495|^496|^497|^498|^499|^500|^501|^502|^503|^504|^505|^5064|^5081|^5088", x[[code]]))
  diabunc <- max(grepl("^2500|^2501|^2502|^2503", x[[code]]))
  diabc <- max(grepl("^2504|^2505|^2506|^2507|^2508|^2509", x[[code]]))
  hypothy <- max(grepl("^2409|^243|^244|^2461|^2468", x[[code]]))
  rf <- max(grepl("^40301|^40311|^40391|^40402|^40403|^40412|^40413|^40492|^40493|^585|^586|^5880|^V420|^V451|^V56", x[[code]]))
  ld <- max(grepl("^07022|^07023|^07032|^07033|^07044|^07054|^0706|^0709|^4560|^4561|^4562|^570|^571|^5722|^5723|^5724|^5725|^5726|^5727|^5728|^5733|^5734|^5738|^5739|^V427", x[[code]]))
  pud <- max(grepl("^5317|^5319|^5327|^5329|^5337|^5339|^5347|^5349", x[[code]]))
  aids <- max(grepl("^042|^043|^044", x[[code]]))
  lymph <- max(grepl("^200|^201|^202|^2030|^2386", x[[code]]))
  metacanc <- max(grepl("^196|^197|^198|^199", x[[code]]))
  solidtum <- max(grepl("^140|^141|^142|^143|^144|^145|^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|^159|^160|^161|^162|^163|^164|^165|^166|^167|^168|^169|^170|^171|^172|^174|^175|^176|^177|^178|^179|^180|^181|^182|^183|^184|^185|^186|^187|^188|^189|^190|^191|^192|^193|^194|^195", x[[code]]))
  rheumd <- max(grepl("^446|^7010|^7100|^7101|^7102|^7103|^7104|^7108|^7109|^7112|^714|^7193|^720|^725|^7285|^72889|^72930", x[[code]]))
  coag <- max(grepl("^286|^2871|^2873|^2874|^2875", x[[code]]))
  obes <- max(grepl("^2780", x[[code]]))
  wloss <- max(grepl("^260|^261|^262|^263|^7832|^7994", x[[code]]))
  fed <- max(grepl("^2536|^276", x[[code]]))
  blane <- max(grepl("^2800", x[[code]]))
  dane <- max(grepl("^2801|^2802|^2803|^2804|^2805|^2806|^2807|^2808|^2809|^281", x[[code]]))
  alcohol <- max(grepl("^2652|^2911|^2912|^2913|^2915|^2916|^2917|^2918|^2919|^3030|^3039|^3050|^3575|^4255|^5353|^5710|^5711|^5712|^5713|^980|^V113", x[[code]]))
  drug <- max(grepl("^292|^304|^3052|^3053|^3054|^3055|^3056|^3057|^3058|^3059|^V6542", x[[code]]))
  psycho <- max(grepl("^2938|^295|^29604|^29614|^29644|^29654|^297|^298", x[[code]]))
  depre <- max(grepl("^2962|^2963|^2965|^3004|^309|^311", x[[code]]))
  out <- list()
  out[[id]] <- unique(x[[id]])
  out$chf <- chf
  out$carit <- carit
  out$valv <- valv
  out$pcd <- pcd
  out$pvd <- pvd
  out$hypunc <- hypunc
  out$hypc <- hypc
  out$para <- para
  out$ond <- ond
  out$cpd <- cpd
  out$diabunc <- diabunc
  out$diabc <- diabc
  out$hypothy <- hypothy
  out$rf <- rf
  out$ld <- ld
  out$pud <- pud
  out$aids <- aids
  out$lymph <- lymph
  out$metacanc <- metacanc
  out$solidtum <- solidtum
  out$rheumd <- rheumd
  out$coag <- coag
  out$obes <- obes
  out$wloss <- wloss
  out$fed <- fed
  out$blane <- blane
  out$dane <- dane
  out$alcohol <- alcohol
  out$drug <- drug
  out$psycho <- psycho
  out$depre <- depre
  out <- data.frame(out)
  return(out)
}

#' @keywords internal
elixhauser_icd10 <- function(x, id, code) {
  chf <- max(grepl("^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290", x[[code]]))
  carit <- max(grepl("^I441|^I442|^I443|^I456|^I459|^I47|^I48|^I49|^R000|^R001|^R008|^T821|^Z450|^Z950", x[[code]]))
  valv <- max(grepl("^A520|^I05|^I06|^I07|^I08|^I091|^I098|^I34|^I35|^I36|^I37|^I38|^I39|^Q230|^Q231|^Q232|^Q233|^Z952|^Z953|^Z954", x[[code]]))
  pcd <- max(grepl("^I26|^I27|^I280|^I288|^I289", x[[code]]))
  pvd <- max(grepl("^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959", x[[code]]))
  hypunc <- max(grepl("^I10", x[[code]]))
  hypc <- max(grepl("^I11|^I12|^I13|^I15", x[[code]]))
  para <- max(grepl("^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839", x[[code]]))
  ond <- max(grepl("^G10|^G11|^G12|^G13|^G20|^G21|^G22|^G254|^G255|^G312|^G318|^G319|^G32|^G35|^G36|^G37|^G40|^G41|^G931|^G934|^R470|^R56", x[[code]]))
  cpd <- max(grepl("^I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703", x[[code]]))
  diabunc <- max(grepl("^E100|^E101|^E109|^E110|^E111|^E119|^E120|^E121|^E129|^E130|^E131|^E139|^E140|^E141|^E149", x[[code]]))
  diabc <- max(grepl("^E102|^E103|^E104|^E105|^E106|^E107|^E108|^E112|^E113|^E114|^E115|^E116|^E117|^E118|^E122|^E123|^E124|^E125|^E126|^E127|^E128|^E132|^E133|^E134|^E135|^E136|^E137|^E138|^E142|^E143|^E144|^E145|^E146|^E147|^E148", x[[code]]))
  hypothy <- max(grepl("E00|^E01|^E02|^E03|^E890", x[[code]]))
  rf <- max(grepl("^I120|^I131|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992", x[[code]]))
  ld <- max(grepl("^B18|^I85|^I864|^I982|^K70|^K711|^K713|^K714|^K715|^K717|^K72|^K73|^K74|^K760|^K762|^K763|^K764|^K765|^K766|^K767|^K768|^K769|^Z944", x[[code]]))
  pud <- max(grepl("^K257|^K259|^K267|^K269|^K277|^K279|^K287|^K289", x[[code]]))
  aids <- max(grepl("^B20|^B21|^B22|^B24", x[[code]]))
  lymph <- max(grepl("^C81|^C82|^C83|^C84|^C85|^C88|^C96|^C900|^C902", x[[code]]))
  metacanc <- max(grepl("^C77|^C78|^C79|^C80", x[[code]]))
  solidtum <- max(grepl("^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C97", x[[code]]))
  rheumd <- max(grepl("^L940|^L941|^L943|^M05|^M06|^M08|^M120|^M123|^M30|^M310|^M311|^M312|^M313|^M32|^M33|^M34|^M35|^M45|^M461|^M468|^M469", x[[code]]))
  coag <- max(grepl("^D65|^D66|^D67|^D68|^D691|^D693|^D694|^D695|^D696", x[[code]]))
  obes <- max(grepl("^E66", x[[code]]))
  wloss <- max(grepl("^E40|^E41|^E42|^E43|^E44|^E45|^E46|^R634|^R64", x[[code]]))
  fed <- max(grepl("^E222|^E86|^E87", x[[code]]))
  blane <- max(grepl("^D500", x[[code]]))
  dane <- max(grepl("^D508|^D509|^D51|^D52|^D53", x[[code]]))
  alcohol <- max(grepl("^F10|^E52|^G621|^I426|^K292|^K700|^K703|^K709|^T51|^Z502|^Z714|^Z721", x[[code]]))
  drug <- max(grepl("^F11|^F12|^F13|^F14|^F15|^F16|^F18|^F19|^Z715|^Z722", x[[code]]))
  psycho <- max(grepl("^F20|^F22|^F23|^F24|^F25|^F28|^F29|^F302|^F312|^F315", x[[code]]))
  depre <- max(grepl("^F204|^F313|^F314|^F315|^F32|^F33|^F341|^F412|^F432", x[[code]]))
  out <- list()
  out[[id]] <- unique(x[[id]])
  out$chf <- chf
  out$carit <- carit
  out$valv <- valv
  out$pcd <- pcd
  out$pvd <- pvd
  out$hypunc <- hypunc
  out$hypc <- hypc
  out$para <- para
  out$ond <- ond
  out$cpd <- cpd
  out$diabunc <- diabunc
  out$diabc <- diabc
  out$hypothy <- hypothy
  out$rf <- rf
  out$ld <- ld
  out$pud <- pud
  out$aids <- aids
  out$lymph <- lymph
  out$metacanc <- metacanc
  out$solidtum <- solidtum
  out$rheumd <- rheumd
  out$coag <- coag
  out$obes <- obes
  out$wloss <- wloss
  out$fed <- fed
  out$blane <- blane
  out$dane <- dane
  out$alcohol <- alcohol
  out$drug <- drug
  out$psycho <- psycho
  out$depre <- depre
  out <- data.frame(out)
  return(out)
}