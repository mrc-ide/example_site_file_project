# Mission control --------------------------------------------------------------
## Below we outline the whole process for ordering and calling orderly2 jobs
# ------------------------------------------------------------------------------

# Cluster set up ---------------------------------------------------------------
## Prepare for cluster use
## see https://mrc-ide.github.io/hipercow/
hipercow::hipercow_init(driver = 'windows')
## Provision packages required on the cluster
## see https://mrc-ide.github.io/hipercow/articles/packages.html
hipercow::hipercow_provision()
# hipercow::hipercow_configuration()
# ------------------------------------------------------------------------------

# Import and document any inputs/data from outside the project -----------------
orderly2::orderly_run(name = "data")
# ------------------------------------------------------------------------------

# Import the base site-file ----------------------------------------------------
orderly2::orderly_run(name = "site_file")
# ------------------------------------------------------------------------------

# Make and adjustments/update to the base site-file ----------------------------
orderly2::orderly_run(name = "adjust_site_file")
# ------------------------------------------------------------------------------

# Recalibrate the site file ----------------------------------------------------
## This step may not be required, depending on updates in previous steps
## This is done on the cluster, sending the site_file to a multi-core node
## where individual site calibrations are run in parallel.
## You will need to ensure that the cluster set up section above has been run
## successfully prior to running this report.
calibration_task <- hipercow::task_create_expr(
  orderly2::orderly_run(name = "calibration"),
  parallel = hipercow::hipercow_parallel("parallel"),
  resources = hipercow::hipercow_resources(cores = 32)
)
# ------------------------------------------------------------------------------

# Design scenarios -------------------------------------------------------------

# ------------------------------------------------------------------------------

# Run scenarios ----------------------------------------------------------------

# ------------------------------------------------------------------------------

# Process, visualise and summarise ---------------------------------------------

# ------------------------------------------------------------------------------