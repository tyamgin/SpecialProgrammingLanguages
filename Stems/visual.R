library(rjson)

HCtoJSON<-function(hc){
  
  labels<-hc$labels
  merge<-data.frame(hc$merge)
  
  for (i in (1:nrow(merge))) {
    if      (merge[i,1]<0 & merge[i,2]<0) {eval(parse(text=paste0("node", i, "<-list(name='node", i, "', children=list(list(name=labels[-merge[i,1]]),list(name=labels[-merge[i,2]])))")))}
    else if (merge[i,1]>0 & merge[i,2]<0) {eval(parse(text=paste0("node", i, "<-list(name='node", i, "', children=list(node", merge[i,1], ", list(name=labels[-merge[i,2]])))")))}
    else if (merge[i,1]<0 & merge[i,2]>0) {eval(parse(text=paste0("node", i, "<-list(name='node", i, "', children=list(list(name=labels[-merge[i,1]]), node", merge[i,2],"))")))}
    else if (merge[i,1]>0 & merge[i,2]>0) {eval(parse(text=paste0("node", i, "<-list(name='node", i, "', children=list(node",merge[i,1] , ", node" , merge[i,2]," ))")))}
  }
  eval(parse(text=paste0("JSON<-toJSON(node",nrow(merge)-1, ")")))
  return(JSON)
}

D3Dendo<-function(JSON, height=800, width=700, file_out){
  
  header<-paste0("
          <!DOCTYPE html>
              <meta charset='utf-8'>
              <link rel='stylesheet' type='text/css' href='style.css'>
              
              <body>
                <script src='d3js.min.js'></script>
                <script src='jquery-2.1.1.min.js'></script>

                <script type='application/json' id='data'>")
  
  footer<-paste0("
                </script>
                 
                <script>
                  var width = ", width, ",
                      height = ", height, ";
                </script>
                <script src='footer.js'></script>
              </body>
          </html>")
  
  fileConn<-file(file_out)
  writeLines(paste0(header, JSON, footer), fileConn)
  close(fileConn)
}