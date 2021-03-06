# Create file variable to hold .csv filename.
filename = 'current_employment_statistics.csv'

# Conditional main.
if(!file.exists(filename)){
	url = 'http://www.bls.gov/web/empsit/ceseesummary.htm'
	txt = join(readLines(url))
	
	# Implementation of SIT function to extract data and format cells.
	temp = extract.table.from.webpage(txt, 'Current Employment Statistics', hasHeader = T)
	colnames(temp)[1] = 'Category'
	colnames(temp)[2:(ncol(temp)-1)] = colnames(temp)[3:ncol(temp)]
	
	# Trims and formats the scraped data to a readable/transferable format.
	temp = trim(temp[-62,1:14])
	temp = temp[complete.cases(temp[1:nrow(temp)]),]
	temp[is.na(temp)] = ""
	
	# Formats the scraped data into a viewable Data Frame structure.
	info = data.frame(stringsAsFactors = F,
	category = as.character(temp[,'Category']),
	decPred  = as.numeric(temp[,(colnames(temp)[2])]),
	jan      = as.numeric(temp[,(colnames(temp)[3])]),
	feb      = as.numeric(temp[,(colnames(temp)[4])]),
	mar      = as.numeric(temp[,(colnames(temp)[5])]),
	apr      = as.numeric(temp[,(colnames(temp)[6])]),
	may      = as.numeric(temp[,(colnames(temp)[7])]),
	jun      = as.numeric(temp[,(colnames(temp)[8])]),
	jul      = as.numeric(temp[,(colnames(temp)[9])]),
	aug      = as.numeric(temp[,(colnames(temp)[10])]),
	sep      = as.numeric(temp[,(colnames(temp)[11])]),
	oct      = as.numeric(temp[,(colnames(temp)[12])]),
	nov      = as.numeric(temp[,(colnames(temp)[13])]),
	decSucc  = as.numeric(temp[,(colnames(temp)[14])]),
	
	# Creates .csv (Excel) file with the Data Frame info. 
	write.csv(info, file = filename)	
}