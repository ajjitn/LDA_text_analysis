#If needed install httr package
#install.packages("httr")

post_labels = function(wiki_ids, user, passwd, label){
  library(httr)
  nrow = length(wiki_ids)
  payload_success = numeric(nrow)
  for (i in seq_along(wiki_ids)){
    payload = list(list(prefix = c('global'), name=label))
    s=POST(sprintf("https://wiki.autodesk.com/rest/api/content/%s/label", wiki_ids[i]),
           authenticate(user, passwd), body=payload, encode = c("json"))
    if (s$status_code == 200){
      print(paste0('wiki page ',wiki_ids[i],' was succesful'))
      payload_success[i] = wiki_ids[i]
    }else{
      print(paste0('wiki page ',wiki_ids[i], ' FAILS'))
      payload_success[i] = NA 
    }
  }
  length_output = sum(!is.na(payload_success))
  print(paste0('function succesfully posted labels for ',length_output,' out of ', nrow," wiki pages"))
  return(payload_success)
}  