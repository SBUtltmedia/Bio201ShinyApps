library(shiny)
outputPath <- "/apps-data"


shinyServer(function(input, output, session) {

  observe({
    if (input$start_proc > 0) {
      Sys.sleep(2)
      session$sendCustomMessage("download_ready", list(fileSize= "Ready"))
    }
  })
  
  output$data_file <- downloadHandler(
    filename <- function() {
      paste("output", "tar", sep=".")
    },
    
    content <- function(file) {
      tar(file, outputPath)
    }
  )
})