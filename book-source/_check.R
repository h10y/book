library(urlchecker)
check_urls <- function (dir=".") {
  urlchecker:::with_pandoc_available(0)
  urls <- path <- character()
  rfiles <- list.files(dir, pattern = "\\.Rmd$", full.names = TRUE)
  for (rfile in rfiles) {
      if (!is.na(rfile) && nzchar(Sys.which("pandoc"))) {
          rpath <- asNamespace("tools")$.file_path_relative_to_dir(rfile, dir)
          tfile <- tempfile(fileext = ".html")
          on.exit(unlink(tfile), add = TRUE)
          out <- urlchecker:::.pandoc_md_for_CRAN2(rfile, tfile)
          if (!out$status) {
              rurls <- urlchecker:::tools$.get_urls_from_HTML_file(tfile)
              urls <- c(urls, rurls)
              path <- c(path, rep.int(rpath, length(rurls)))
          }
      }
  }
  # probably need to remove localhost from the list
#   keep <- !grepl("127\\.0\\.0\\.1", urls)
#   urls <- urls[keep]
#   path <- path[keep]
  db <- urlchecker:::tools$url_db(urls, path)
  res <- urlchecker:::tools$check_url_db(db, verbose = FALSE, parallel = TRUE, pool = curl::new_pool())
  if (NROW(res) > 0) {
    res$root <- normalizePath(dir)
  }
  class(res) <- c("urlchecker_db", class(res))
  res
}
# list.files("book-source", pattern = "\\.Rmd$") |> sort() |> cat(sep="\",\n\"")
check_urls()
