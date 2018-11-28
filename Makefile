all: common_words.tsv

clean:
	rm -f files/dataset_merge.txt files/common_words.tsv render_bar_plot.png render_cloud_plot.png

render_cloud_plot.png: cloud.pdf
	cp $< $@
	
render_bar_plot.png: bar_plot.png
	cp $< $@

common_words.tsv: trump_words.r dataset_merge.txt
	Rscript $<

dataset_merge.txt: merger.py
	./merger.py $< $@

