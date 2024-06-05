# Orderly set up ---------------------------------------------------------------
orderly2::orderly_description(
  display = "Scenarios",
  long = "Design scenarios"
)

# Dependencies come from previously run reports
orderly2::orderly_dependency(
  name = "calibration",
  query = "latest()",
  files = c(
    "calibrated_site_file.rds"
  )
)

orderly2::orderly_parameters(
  scenario = NULL
)

orderly2::orderly_artefact(
  description = "Scenarios",
  files = c("scenario.rds")
) 
# ------------------------------------------------------------------------------

# Design two future scenarios, A and B -----------------------------------------
site <- readRDS("calibrated_site_file")


## Here you extend and modify the site file interventions section (future)
## Use the scene package for helpful functionality to do so
## https://github.com/mrc-ide/scene
## Remember:
### 1. You will need to re-evaluate the ITN input distribution when modifying ITN use

if(scenario == "a"){
   # Modify site$interventions
}

if(scenario == "b"){
  # Modify site$interventions
}

saveRDS(site, "scenario.rds")
# ------------------------------------------------------------------------------
