
install:
	R -q -e 'if(!require(deps)){install.packages("deps")};deps::install(ask=FALSE)'

clean:
	R -q -e 'bookdown::clean_book(TRUE)' && rm -fvr figures/* HostingShiny.* spelling.csv urlcheck.txt *.log Rplots.pdf _bookdown_files land.sqlite3

html:
	R -q -e 'if(!dir.exists("docs")){dir.create("docs")};bookdown::render_book("index.Rmd")'
