inputFileName = raw_input('Enter input file name: ');
outputFileName = raw_input('Enter output file name: ');

inputFile = open(inputFileName,'r');
outputFile = open(outputFileName,'w');

id = 1;
for line in inputFile.readlines():
	location = line.rstrip().split(',');
	city = location[0];
	city = city.replace("'","");
	country = location[1];
	country = country.replace("'","");
	state = location[2];
	state = state.replace("'","");
	outputFile.write("INSERT INTO locations VALUES ("+str(id)+",'"+city+"','"+state+"','"+country+"');\n");
	id = id + 1;

