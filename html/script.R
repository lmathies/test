library(tidyverse)
library(purrr)
library(kableExtra)
library(rvest)
library(stringr)
library(xml2)

# parse URL
url <- "https://en.wikipedia.org/w/index.php?title=List_of_tallest_towers&oldid=1175962653"
url_parsed <- read_html(url)

# extract links from table
xpath <- "//table[@class = 'wikitable sortable'][5]//tbody//td[position()=3]/a[1]"
anchors <- html_nodes(url_parsed, xpath = xpath)
links <- html_attr(anchors, "href")

# fetch real wikipedia pages
baseurl <- "http://en.wikipedia.org"
HTML <- list()
Fname <- str_c(basename(links), ".html")
URL <- str_c(baseurl, links)

# set temporary working directory

setwd("wikipedia-html")

# loop
for ( i in seq_along(links) ){
  # url
  url <- URL[i]
  # fname
  fname <- Fname[i]
  # download
  if ( !file.exists(fname) ) download.file(url, fname)
  # read in files
  HTML[[i]] <- read_html(fname)
}