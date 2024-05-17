# Orderly set up ---------------------------------------------------------------
orderly2::orderly_description(
  display = "Calibrate",
  long = "Calibration of updated site file"
)

# Dependencies come from previously run reports
orderly2::orderly_dependency(
  name = "adjust_site_file",
  query = "latest()",
  files = c(
    "adjusted_site_file.rds"
  )
)

orderly2::orderly_resource(
  files = "calibration_utils.R"
)

orderly2::orderly_artefact(
  description = "Calibrated site file",
  files = "calibrated_site_file.rds"
) 
# ------------------------------------------------------------------------------

# Run calibration --------------------------------------------------------------
# Load utility function
source("calibration_utils.R")

# Load the adjusted site_file
site <- readRDS("adjusted_site_file.rds")

# Set some parameters
human_population <- c(5000, 10000, 100000)
diagnostic_burnin <- 2  # TODO: increase for full run 
max_attempts <- 10

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

calibration_output <- parallel::parLapply(
  cl = cluster,
  X = eirs,
  fun = calibrate_site,
  site = site,
  human_population = human_population,
  diagnostic_burnin = diagnostic_burnin,
  max_attempts = max_attempts
)
parallel::stopCluster(cl = cluster)

# TODO: 
## This is where any calibration diagnostic summaries/runs can be created as
## outputs.

# Collate EIR
eir_estimates <- 
  lapply(calibration_output, "[[", 1) |>
  dplyr::bind_rows()

site$eir <- eir_estimates
saveRDS(site, "calibrated_site_file.rds")
# ------------------------------------------------------------------------------