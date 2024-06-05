# Orderly set up ---------------------------------------------------------------
orderly2::orderly_description(
  display = "Post processing",
  long = "Post processing, formating and visualisation"
)

# Dependencies come from previously run reports
scenarios <- c("a", "b")
for(scenario in scenarios){
  name <- paste0("scenario_", scenario, ".rds")
  orderly2::orderly_dependency(
    name = "scenario",
    query = "latest(parameter:scenario == this:scenario)",
    files = c(
      name = "scenario.rds"
    )
  )
}

orderly2::orderly_artefact(
  description = "Plot results",
  files = "plot_out.png"
) 
# ------------------------------------------------------------------------------

# Post process and visualise ---------------------------------------------------
scenario_a <- readRDS("scenario_a.rds")
scenario_b <- readRDS("scenario_b.rds")

# Code to compare sceanios

# Code to plot comparison results etc.
ggplot2::ggsave("plot_out.png", myplot)
# ------------------------------------------------------------------------------