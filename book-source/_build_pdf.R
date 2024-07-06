# This script is used to create PDF of the book and all TeX files for CRC Press.

# Keep all the intermediary files so they can be copied below. This step also
# generates the .tex file in the `docs` folder
options(tinytex.clean = FALSE)
bookdown::render_book("index.Rmd", 
  bookdown::pdf_book(
    pandoc_args="--top-level-division=chapter",
    latex_engine = "xelatex",
    keep_tex = TRUE,
    toc_depth = 3,
    toc_unnumbered = FALSE,
    toc_appendix = TRUE,
    quote_footer = c("\\VA{", "}{}"),
    highlight_bw = FALSE,
    includes = list(
      in_header="latex/preamble.tex",
      before_body="latex/before_body.tex",
      after_body="latex/after_body.tex")
    ),
  clean = FALSE,
  encoding = "UTF-8"
)

# Copy R generated figures
if (!dir.exists(file.path("docs", "figures"))) {
  tmp <- dir.create(file.path("docs", "figures"),
    recursive = TRUE
  )
}
tmp <- file.copy(from = "figures", to = "docs", recursive = TRUE)

# Copy references over
if (!dir.exists(file.path("docs", "bib"))) {
  tmp <- dir.create(file.path("docs", "bib"))
}
tmp <- file.copy(from = "bib", to = "docs", recursive = TRUE)

# For printing the PDF from the .tex file
if (!dir.exists("docs")) {
  tmp <- dir.create("docs")
}
tmp <- file.copy("krantz.cls",
  file.path("docs", "krantz.cls"),
  overwrite = TRUE
)

# Clean up extra files
extra_extensions <- c(
  ".bbl", ".blg", ".idx", ".ilg", ".ind",
  ".log", ".synctex.gz", ".toc", ".aux"
)
# extra_files <- file.path("docs", paste0("HostingShiny", extra_extensions))
# suppressWarnings({tmp <- file.remove(file.path(paste0("HostingShiny", extra_extensions)))})
suppressWarnings({tmp <- file.remove(file.path("docs", paste0("HostingShiny", extra_extensions)))})
