lintr::lint_dir()
library(lintr)
dr <- "."
rmd_files <- list.files(dir, pattern = "\\.Rmd$", full.names = TRUE)

lint(
       filename,
       linters = NULL,
       ...,
       cache = FALSE,
       parse_settings = TRUE,
       text = NULL
     )

i <- 2
lint(rmd_files[i], lintr::linters_with_defaults())
lint(rmd_files[i], pkgpurl::default_linters)

lint_dir(dir, pattern = "(?i)[.](rmd)$")

