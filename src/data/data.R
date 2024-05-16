orderly2::orderly_description(
  "Import and document any external data sources here"
)

input_files <- list.files("inputs/", full.names = TRUE)

orderly2::orderly_resource(input_files)

orderly2::orderly_artefact(
  description = "Describe inputs here",
  files = input_files
)

orderly2::orderly_resource("README.md")
