# Mission control --------------------------------------------------------------
## Below we outline the whole process for ordering and calling orderly2 jobs
# ------------------------------------------------------------------------------

# Cluster set up ---------------------------------------------------------------
## Prepare for cluster use -see https://mrc-ide.github.io/hipercow/
hipercow::hipercow_init(driver = 'windows')
## PRovision packages required on the cluster - see https://mrc-ide.github.io/hipercow/articles/packages.html
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

# ------------------------------------------------------------------------------

# Recalibrate the site file ----------------------------------------------------
## This step may not be required, depending on updates in previous steps
# ------------------------------------------------------------------------------

# Design scenarios -------------------------------------------------------------

# ------------------------------------------------------------------------------

# Run scenarios ----------------------------------------------------------------

# ------------------------------------------------------------------------------

# Process, visualise and summarise ---------------------------------------------

# ------------------------------------------------------------------------------