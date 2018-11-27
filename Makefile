all: word_freq.tsv

clean:
	rm -f files/dataset_merge.txt files/word_freq.tsv

word_freq.tsv: trump_words.r dataset_merge.txt
	Rscript $<

dataset_merge.txt: merger.py
	./merger.py $< $@

