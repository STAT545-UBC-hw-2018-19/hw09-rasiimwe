all: common_words.tsv

clean:
	rm -f files/dataset_merge.txt files/word_freq.tsv files/common_words.tsv


common_words.tsv: trump_words.r dataset_merge.txt
	Rscript $<

dataset_merge.txt: merger.py
	./merger.py $< $@

