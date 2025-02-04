#! /bin/bash
if [ $# -gt 0 ]
then   	
	for arg in "$@"

	do
		mkdir "ex$@"
		echo "ex$@"
	done	

else 
	echo "No arguments supplied"
fi

