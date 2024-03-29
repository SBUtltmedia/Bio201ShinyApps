library(shiny)

shinyUI(fluidPage(
  singleton(tags$head(HTML(
    '
  <script type="text/javascript">
    $(document).ready(function() {
      // disable download at startup. data_file is the id of the downloadButton
      $("#data_file").attr("disabled", "true").attr("onclick", "return false;");

      Shiny.addCustomMessageHandler("download_ready", function(message) {
        $("#data_file").removeAttr("disabled").removeAttr("onclick").html(
          "<i class=\\"fa fa-download\\"></i>Download " + message.fileSize + " ");
      });
    })
  </script>
'
  ))),
  tabsetPanel(
    tabPanel('BIO 201 Apps Data Download',
             actionButton("start_proc", h5("Click to start processing data")),
             hr(),
             
             downloadButton("data_file"),
             helpText("Download for all apps will be available once the processing is completed.")
    )
  )
))
