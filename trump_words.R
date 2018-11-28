
# Install following packages 
#install.packages("tm")  # for text mining
#install.packages("SnowballC") # for text stemming
#install.packages("wordcloud") # word-cloud generator 
#install.packages("RColorBrewer") # color palettes
#install.packages("webshot")
#webshot::install_phantomjs()


#load
suppressPackageStartupMessages(library(ggplot2)) #will be required to make some plots
suppressPackageStartupMessages(library(tidyverse)) #provides system of packages for data manipulation
suppressPackageStartupMessages(library(purrr))#to provide tools for working with functions and vectors like map()
suppressPackageStartupMessages(library(RColorBrewer))#provide color palette
suppressPackageStartupMessages(library(tibble))
suppressPackageStartupMessages(library(repurrrsive))
suppressPackageStartupMessages(library(tidytext))
suppressPackageStartupMessages(library(dplyr))# for required data manipulation
suppressPackageStartupMessages(library(stringr)) #avails string functions 
suppressPackageStartupMessages(library(tm))
suppressPackageStartupMessages(library(SnowballC))
suppressPackageStartupMessages(library(wordcloud))
suppressPackageStartupMessages(library(RColorBrewer))

#loading merged dataset
trump_tweets_df<-read.csv("files/dataset_merge.txt", sep=",")

#creating neader dataset to work with- tweets2
regex_words <- "([^A-Za-z_\\d#@']|'(?![A-Za-z_\\d#@]))" 
tweets2 <- trump_tweets_df %>%
	filter(!str_detect(Text, "^QRT")) %>%
	mutate(Text = str_replace_all(Text, "https://t.co/[A-Za-z\\d]+|http://[A-Za-z\\d]+|&amp;|&lt;|&gt;|RT|https", "")) %>%
	unnest_tokens(word, Text, token = "regex", pattern = regex_words) %>%
	filter(!word %in% stop_words$word,
				 str_detect(word, "[a-z]"))


words <- tweets2$word
words <- Corpus(VectorSource(words))
#inspect(words)


#Build a term-document matrix
data_matrix <- TermDocumentMatrix(words)
mtx <- as.matrix(data_matrix)
sort_mtx <- sort(rowSums(mtx),decreasing=TRUE)
word_freq <- data.frame(word = names(sort_mtx),freq=sort_mtx)
#head(d, 10)


#write.table(word_freq, "files/word_freq.tsv",
				#		sep = "\t", row.names = FALSE, quote = FALSE)


set.seed(1234)
cloud <- wordcloud(words = word_freq$word, freq = word_freq$freq, min.freq = 1,
					max.words=200, random.order=FALSE, rot.per=0.35, 
					colors=brewer.pal(8, "Dark2"), size=3)
#dev.copy2pdf(file="files/cloud.pdf", width = 7, height = 7) #used to render cloud


common_words <- tweets2 %>%
	count(word, sort=TRUE) %>%
	filter(substr(word, 1, 1) != '#', # omiting hashtags
				 substr(word, 1, 1) != '@', # omiting Twitter handles
				 n > 80) %>% # only most common words
	mutate(word = reorder(word, n))

names(common_words)[names(common_words)=='n'] <- 'word_frequency'



write.table(common_words, "common_words.tsv",
	sep = "\t", row.names = FALSE, quote = FALSE)

bar_plot <- common_words %>%  ggplot(aes(word, word_frequency)) +
	geom_bar(stat = 'identity', fill=c("gray50")) +
	xlab(NULL) +
	ylab(paste('Word count', sep = '')) +
	ggtitle(paste('common words in Trumps tweets')) +
	theme(legend.position="none") +
	coord_flip() +
	theme_bw() +
	theme(plot.title = element_text(hjust = 0.5))

#ggsave("files/bar_plot.png", bar_plot) 


