all: dataset_merge.txt

clean:
	rm -f dataset_merge.txt


dataset_merge.txt: merger.py
	./merger.py $< $@

