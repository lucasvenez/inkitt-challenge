#
# Setting workspace
#
setwd("/home/lucas/git/inkitt-challenge/")
#
# Required libraries intallation
#
install.packages("devtools")
devtools::install_github("bmschmidt/wordVectors")
#
# Loading require libraries
#
library(wordVectors)
library(magrittr)
#
# Loading required sources
#
source("./task_03.black.list.r")
source("./task_03.countries.r")
#
# Loading word2vector
# This data is enabled at
# https://drive.google.com/uc?id=0B7XkCwpI5KDYNlNUTTlSS21pQmM&export=download
# It has 3.5GiB uncrompressed. Please, download this file to run this code.
#
vector = read.binary.vectors("./data/GoogleNews-vectors-negative300.bin", nrows = 200000)
stories <- read.csv('./data/stories.csv', sep=',', header=T)
#
# Removing invalid stories
#
stories <- stories[stories$title != "Untitled",]
#
# Getting possible countries
#
res <- apply(stories, 1, function(row) {
       #
       # Formmating text
       #
       teaser <- row['teaser']
       teaser <- unlist(strsplit(gsub(' +', ' ', teaser), ' '))
       teaser <- teaser[grep("^[A-Z]",teaser)]
       teaser <- unlist(lapply(teaser, function(x) ifelse(!tolower(x) %in% black.list, x, NA)))
       teaser <- teaser[!is.na(teaser)]
       #
       # Calculating words similarity
       #
       result = data.frame(country=c(), similarity=c())
       #
       # For each word calculate similarity using word2vector
       #
       for (word in teaser) {
          f <- paste("~", "\"", word, "\"+", sep="")
          f <- as.formula(paste(f, "\"countries\"", sep=""))
          closest <- (vector %>% closest_to(f))
          index <- which(closest$word[1:20] %in% as.character(COUNTRIES$name))
          result <- rbind(result, data.frame(country=closest$word[index], similarity=closest$similarity[index]))
       }
       #
       # Returning results
       #
       list(as.character(row[3]), result[order(-result$similarity),])
})
#
# Printing results
#
for (r in res) {
  writeLines("\n============================================")
  writeLines(r[[1]])
  writeLines("")
  print(r[[2]])
}