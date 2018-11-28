all: report.html

clean:
	rm -f files/dataset_merge.txt files/common_words.tsv render_bar_plot.png render_cloud_plot.pdf report.rmd 

report.html:report.rmd

report.rmd: common_words.tsv render_bar_plot.png render_cloud_plot.pdf 
	Rscript -e 'rmarkdown::render("$<")'
	
render_cloud_plot.pdf: files/cloud.pdf
	cp $< $@
	
render_bar_plot.png: files/bar_plot.png
	cp $< $@

common_words.tsv: trump_words.r dataset_merge.txt
	Rscript $<

dataset_merge.txt: merger.py
	./merger.py $< $@

