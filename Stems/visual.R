library(rjson)

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