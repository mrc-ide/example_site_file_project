# Orderly set up ---------------------------------------------------------------
orderly2::orderly_description(
  display = "Update base site file",
  long = "Ammending the base site file to account for additiona data inputs and other
  contextual information"
)

# Dependencies come from previously run reports
orderly2::orderly_dependency(
  name = "create_base_site_file",
  query = "latest()",
  files = c(
    "site_file.rds"
  )
)

orderly2::orderly_artefact(
  description = "Adjusted site file",
  files = "adjusted_site_file.rds"
) 
# ------------------------------------------------------------------------------

# Make adjustments -------------------------------------------------------------
site_file <- readRDS("site_file.rds")

# Adjustments
# adjusted_site_file <- site_file

saveRDS(adjusted_site_file, "adjusted_site_file.rds")
# ------------------------------------------------------------------------------