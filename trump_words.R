suppressPackageStartupMessages(library(ggplot2)) #will be required to make some plots
suppressPackageStartupMessages(library(tidyverse)) #provides system of packages for data manipulation
suppressPackageStartupMessages(library(purrr))#to provide tools for working with functions and vectors like map()
suppressPackageStartupMessages(library(RColorBrewer))#provide color palette
suppressPackageStartupMessages(library(tibble))
suppressPackageStartupMessages(library(repurrrsive))
suppressPackageStartupMessages(library(tidytext))


suppressPackageStartupMessages(library(dplyr))# for required data manipulation
suppressPackageStartupMessages(library(stringr)) #avails string functions 



trump_tweets_df<-read.csv("file_1.txt", sep=",")

tweets <- trump_tweets_df$Text #subseting the data to work with a small piece of it
words <- regex <- "badly|crazy|weak|spent|strong|dumb|joke|guns|funny|dead" #common words associated with Trump tweets
tweets <- tweets[c(2, 4, 6, 8)]
str(tweets) #character of 4 elements
tweets


regex_words <- "([^A-Za-z_\\d#@']|'(?![A-Za-z_\\d#@]))" 
tweets2 <- trump_tweets_df %>%
	filter(!str_detect(Text, "^QRT")) %>%
	mutate(Text = str_replace_all(Text, "https://t.co/[A-Za-z\\d]+|http://[A-Za-z\\d]+|&amp;|&lt;|&gt;|RT|https", "")) %>%
	unnest_tokens(word, Text, token = "regex", pattern = regex_words) %>%
	filter(!word %in% stop_words$word,
				 str_detect(word, "[a-z]"))

words <- tweets2$word
words <- Corpus(VectorSource(words))
inspect(words)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
words <- tm_map(words, toSpace, "/")
words <- tm_map(words, toSpace, "@")
words <- tm_map(words, toSpace, "\\|")

##some cleaning
#Convert the text to lower case
words <- tm_map(words, content_transformer(tolower))
# Remove numbers
words <- tm_map(words, removeNumbers)
# Remove punctuations
words <- tm_map(words, removePunctuation)
# Eliminate extra white spaces
words <- tm_map(words, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)

#Build a term-document matrix
dtm <- TermDocumentMatrix(words)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
					max.words=200, random.order=FALSE, rot.per=0.35, 
					colors=brewer.pal(8, "Dark2"))






tweets2 %>%
	count(word, sort=TRUE) %>%
	filter(substr(word, 1, 1) != '#', # omiting hashtags
				 substr(word, 1, 1) != '@', # omiting Twitter handles
				 n > 80) %>% # only most common words
	mutate(word = reorder(word, n)) %>%
	ggplot(aes(word, n)) +
	geom_bar(stat = 'identity', fill=c("gray50")) +
	xlab(NULL) +
	ylab(paste('(Word count)', sep = '')) +
	ggtitle(paste('common words in tweets')) +
	theme(legend.position="none") +
	coord_flip() +
	theme_bw() +
	theme(plot.title = element_text(hjust = 0.5))