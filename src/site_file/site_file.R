orderly2::orderly_description(
  "Import and document any base site-file(s) used, the process of accessing
  the latest site-files will be streamlined in the future"
)

input_site_files <- list.files("site_files/", full.names = TRUE)

orderly2::orderly_resource(input_site_files)

orderly2::orderly_artefact(
  description = "Describe site file inputs here",
  files = input_site_files
)

orderly2::orderly_resource("README.md")
