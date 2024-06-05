# Orderly set up ---------------------------------------------------------------
orderly2::orderly_description(
  display = "Calibrate",
  long = "Calibration of updated site file"
)

orderly2::orderly_parameters(
  scenario = NULL
)

# Dependencies come from previously run reports
orderly2::orderly_dependency(
  name = "scenario",
  query = "latest(parameter:scenario == this:scenario)",
  files = c(
    "scenario.rds"
  )
)

orderly2::orderly_resource(
  files = "run_utils.R"
)

orderly2::orderly_artefact(
  description = "Scenario output",
  files = "scenario_output.rds"
) 
# ------------------------------------------------------------------------------

# run the Site scenarios in parallel -------------------------------------------

site <-  readRDS("scenario.rds")

# Split out individual jobs
eirs <- site$eir
eirs <- split(eirs, 1:nrow(eirs))

# Set up parallelisation
cores <- Sys.getenv("CCP_NUMCPUS")
cluster <- parallel::makeCluster(as.integer(cores))
invisible(parallel::clusterCall(cluster, ".libPaths", .libPaths()))
parallel::clusterCall(cluster, function() {
  library(sf)
  library(site)
  library(postie)
  library(cali)
  library(knitr)
  library(dplyr)
  library(ggplot2)
  source("calibration_utils.R")
  TRUE
})

scenario_output <- parallel::parLapply(
  cl = cluster,
  X = eirs,
  fun = run_scenario,
  site = site
)
parallel::stopCluster(cl = cluster)

saveRDS(scenario_output, "scenario_output.rds")
