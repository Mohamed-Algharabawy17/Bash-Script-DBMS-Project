#!/bin/bash


TableMenu() {

	echo "#---------- Table Menu -----------#"
        echo "# 1- Insert into table            #"
        echo "# 2- Exit                         #"
        echo "#---------------------------------#"

	read -p "Enter tour option: " opt
	case $opt in
		1) Insert
			;;
		2) return 
			;;
		*) echo "your option $opt is invalid !"
			;;
	esac
	TableMenu
}



#---------------------------------- Insert ----------------------------------

function Insert {
    read -p "Enter Table name: " table_name


    if [[ -f "$table_name" ]]
    then
        
	col_num=$(awk 'END{print NR}' ".$table_name")
	typeset -i i
	i=1
	while (( $i <= $col_num ))
	do
		Name=$(awk -F'|' '{if(NR=='$i') {print $1}}' ".$table_name")
		Type=$(awk -F'|' '{if(NR=='$i') {print $2}}' ".$table_name")
		Key=$(awk -F'|' '{if(NR=='$i') {print $3}}' ".$table_name")

		read -p "Enter $Name ($Type)> " Usr_Data

		if [[ "$Type" == "int" ]]      # Validate user input datatypes (integer)
		then
			while ! [[ "$Usr_Data" =~ ^[0-9]*$ ]]
			do
				echo "Your data type $Usr_Data is invalid it must be in ($Type) !"
				read -p "Enter $Name ($Type)> " Usr_Data
			done
		fi

		if [[ "$Type" == "str" ]]    # Validate user input datatypes (string)
		then
			while ! [[ "$Usr_Data" =~ ^[A-Za-z]*$ ]]
                        do
                                echo "Your data type $Usr_Data is invalid it must be in ($Type) !"
                                read -p "Enter $Name ($Type)> " Usr_Data
                        done
		fi



		if [[ $Key == "PK" ]]       # Validate user input for primarykey
		then
                	while true
			do
				if grep -q "^$Usr_Data|" "$table_name"
				then
                        		echo "Invalid input for Primary Key!"
                        		read -p "Enter $Name ($Type)> " Usr_Data
                    		else
                        		break
                    		fi
                	done
              fi


	      if [ "$i" -eq "$col_num" ]
	      then
		      row="$row$Usr_Data"
    	      else
		      row="$row$Usr_Data|"
              fi
	      ((i++))
	done


	echo $row" " >> $table_name 
    	if [[ $? == 0 ]]
    	then    
        	echo "Data Inserted Successfully"
   	else
        	echo "Error Inserting Data into Table $tableName"
    	fi
    	row=""

    else
        echo "File $table_name does not exist!"
    fi
}


#--------------------------------- Call Main Menu -----------------------------------------------
TableMenu
#------------------------------------------------------------------------------------------------
