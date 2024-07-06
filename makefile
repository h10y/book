install:
	R -q -e 'if(!require(deps)){install.packages("deps")}'
	R -q -e 'deps::install("book-source", ask=FALSE)'

clean:
	cd book-source; \
	R -q -e 'bookdown::clean_book(TRUE)'; \
	rm -fvr figures/* HostingShiny.* spelling.csv urlcheck.txt *.log Rplots.pdf _bookdown_files land.sqlite3

html:
	cd book-source; \
	R -q -e 'if(!dir.exists("docs")){dir.create("docs")}'; \
	R -q -e "bookdown::render_book('index.Rmd')"
