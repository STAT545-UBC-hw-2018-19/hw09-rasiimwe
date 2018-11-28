all: report.rmd 

clean:
	rm -f files/dataset_merge.txt common_words.tsv render_bar_plot.png render_cloud_plot.pdf bar.png report.rmd


report.rmd: common_words.tsv bar.png render_cloud_plot.pdf render_bar_plot.png
	Rscript -e 'rmarkdown::render("$<")'
	
bar.png: common_words.tsv
	Rscript -e 'library(ggplot2); qplot(word, word_frequency, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf


render_cloud_plot.pdf: files/cloud.pdf
	cp $< $@
	
render_bar_plot.png: files/bar_plot.png
	cp $< $@

common_words.tsv: trump_words.r dataset_merge.txt
	Rscript $<

dataset_merge.txt: merger.py
	./merger.py $< $@

