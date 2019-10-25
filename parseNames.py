inputFileName = raw_input('Enter input file name: ');
outputFileName = raw_input('Enter output file name: ');
nameType = raw_input('Name type (first_f,first_m,last): ');
region = raw_input('Region: ');

inputFile = open(inputFileName,'r');
outputFile = open(outputFileName,'w');

for line in inputFile.readlines():
	name = line.rstrip().title();
	outputFile.write("INSERT INTO names VALUES ('"+name+"','"+nameType+"','"+region+"');\n");

