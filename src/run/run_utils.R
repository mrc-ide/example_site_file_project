run_scenario <- function(x, site, human_population){
  print(x)
  sub_site <- site::subset_site(site, x)
  species <- x$sp
  
  # Define the target prevalence to fit to
  if(species == "pf"){
    scaler <- 0.215
  } else {
    scaler <- 0.003
  }

  # Set parameters
  calibration_burnin <- 5
  p <- site::site_parameters(
    interventions = sub_site$interventions,
    demography = sub_site$demography,
    vectors = sub_site$vectors$vector_species,
    seasonality = sub_site$seasonality$seasonality_parameters,
    overrides = list(
      human_population = human_population
    ),
    species  = species,
    burnin = calibration_burnin
  )
  # Model run
  s <- malariasimulation::run_simulation(timesteps = p$timesteps, parameters = p)
  
  # Do any post-processing here
  
  # Return outputs
}