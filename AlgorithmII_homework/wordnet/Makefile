
all : runtest

compile:
	javac-algs4 *.java

runtest: compile
	# java-algs4 WordNet /Volumes/WORK/qibinyi/Downloads/wordnet/synsets.txt  /Volumes/WORK/qibinyi/Downloads/wordnet/hypernyms.txt 
	java-algs4 WordNet synsets13.txt  hyper13.txt
	# java-algs4 WordNet topo1.txt  topo2.txt 


sap: compile
	java-algs4 SAP  /Volumes/WORK/qibinyi/Downloads/wordnet/digraph5.txt 

out: compile
	java-algs4 Outcast /Volumes/WORK/qibinyi/Downloads/wordnet/synsets.txt /Volumes/WORK/qibinyi/Downloads/wordnet/hypernyms.txt /Volumes/WORK/qibinyi/Downloads/wordnet/outcast5.txt /Volumes/WORK/qibinyi/Downloads/wordnet/outcast8.txt  /Volumes/WORK/qibinyi/Downloads/wordnet/outcast11.txt 


