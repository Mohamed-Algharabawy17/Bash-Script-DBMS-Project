#!/bin/bash

mkdir -p Main 2> ./.errors
clear
function Welcome {
echo -e "\t\t\t\t\t\t\t\tWelcome to our project :)" 
echo -e "\t\t\t\t\t\tEnjoy our features for dealing with Database Management System "
echo -e "\t\t\t\t\t\tDevelpoed by Mohamed Algharabawy & Mohamed Torkey "
echo -e "\n\n\n"
}
Welcome
#-------------------- Print main menu for the user ---------------------

function Print_Menu {
    echo "*---------Main Menu---------*"
    echo "* 1- Create database        *"
    echo "* 2- List databases         *"
    echo "* 3- Connect to database    *"
    echo "* 4- Drop database          *"
    echo "* 5- Exit                   *"
    echo "*---------------------------*"

    read -p "Enter your choice: " choice

    case $choice in
        1) CreateDB ;;
        2) ListDBS ;;
        3) OpenDB ;;
        4) DropDB ;;
        5) exit 1 ;; # For Exit option
        *) echo "Choice $choice is an invalid choice !" ;;
    esac

    Print_Menu                           # print menu again after each operation
}


#------------------------- Create Database -----------------------------

function CreateDB {
    read -p "Enter Database name: " db_name
    if [[ -d "$HOME/Main/$db_name" ]]
    then
	    echo "The $db_name database already exists !"
    else
	    mkdir -p $HOME/Main/$db_name 2> $HOME/.errors
	    echo "Database $db_name created successfully ;)"
    fi
}

#------------------------- List Databases ------------------------------

function ListDBS {
    ls $HOME/Main
}

#------------------------ Connect to Database --------------------------

function OpenDB {
    read -p "Enter Database name: " db_name
    if [[ -d "$HOME/Main/$db_name" ]] 
    then
        cd $HOME/Main/$db_name
	clear
	echo -e "\n Welcome to $db_name Database :)\n\n"
    	Table_Menu

    else
        echo "Database $db_name doesn't exist!"
    fi

}

#------------------------- Drop Database -------------------------------

function DropDB {
    read -p "Enter Database name: " db_name

    if [[ -d "$HOME/Main/$db_name" ]] 
    then
        echo "Are you sure you want to drop the database $db_name? "
        select confirm in "Yes" "No"
        do
        case $confirm in
            "Yes") rm -r "$HOME/Main/$db_name"
                   if [[ ! -d "$HOME/Main/$db_name" ]] 
		   then
                       echo "Database $db_name deleted successfully :)"
                   else
                       echo "Failed to delete database $db_name."
                   fi
                   ;;
            "No")
                   echo "Database $db_name was not deleted."
                   ;;
            *)
                   echo "Invalid input. Database $db_name was not deleted."
                   ;;
        esac
        break
        done
    else
        echo "Database $db_name doesn't exist!"
    fi
}

#------------------------- Table menu -------------------------------

function Table_Menu
{
echo "-------- Main Menu --------"
echo "* 1. Create Table         *"
echo "* 2. List Table           *"
echo "* 3. Drop Table           *"
echo "* 4. Insert Into Table    *"
echo "* 5. Select From Table    *"
echo "* 6. Delete From Table    *"
echo "* 7. Update Table         *"
echo "* 8. Back to Main Menu    *"
echo "* 9. Exit                 *"
echo "---------------------------"

 echo -e "Enter your choice : \c"
  read choice
    case $choice in
        1) Creat_Table
            ;;
        2) ls $HOME/Main/$db_name
            ;;
        3) Drop_Table
            ;;
	4) Insert
            ;;
        5) clear 
	   echo -e "\n Welcome to select menu :)" 
	   Select_Menu
            ;;
        6) Delete
            ;;
        7) Table_update
           ;;
        8) clear; Welcome; Print_Menu
	   ;;
        9) exit 1; clear
            ;;
        *) echo "Invalid choice"
            ;;
    esac

    Table_Menu
}

#------------------------- Creat Table Function -----------------------------

function Creat_Table
{
   read -p "Enter Your Table name: " Table_name

   while ! [[ "$Table_name" =~ ^[A-Za-z]*$ ]]
   do
	echo "Table name must be in String for readability !"
	read -p "Enter Your Table name: " Table_name
   done

   if [ -f "$HOME/Main/$db_name/$Table_name" ]
   then
         echo "$Table_name is already created ,please Enter the anther Name Table " ; Creat_Table
   fi


    typeset -i NC
    typeset -i i
    typeset -i j	

     j=1
    read -p "Enter the number of columns:" N_columns
    while [[ $N_columns < 2 ]]
    do
	    if ! [[ $N_columns < 2 ]] 
	    then
		    break
	    fi
	    echo "Too few columns number to crate this table !"
	    read -p "Enter the number of columns:" N_columns
    done
    if [ $? == 0 ] && [ ! -f "$HOME/Main/$db_name/$Table_name" ]
    then
	  touch "$PWD/$Table_name"
          touch "$PWD/.$Table_name"
    fi
     i=1
     Data="" 
	   
    until [ $i -gt $N_columns ]
    do
         read -p "Enter the name of column.$i:" Name_column
	 while ! [[ "$Name_column" =~ ^[A-Za-z]*$ ]]
	 do
         	echo "Column name must be in String for readability !"
         	read -p "Enter Your column name: " Name_column
    	 done

      
         Data+="$Name_column"
	 Info="$Name_column"
	
         echo "Type of Column $Name_column:"

         select type_col in "int" "str"
           do
           case $type_col in

           "int" )type_int="int"; break;;
           "str" )type_str="str";break;;
           * ) echo "Wrong Choice" ;;
           esac
	 done    

	  Info+="|$type_col"

       if [ $type_col == "int" ]
       then
            if [[ $j == 1 ]]
	    then 
	       read -p "Do you need $Name_column to be Primary key ?[y/n]:" check

		if [ $check = "y" ]
		then
			Info+="|PK|"
		        j=2
		        echo "Your field $Name_column became the primary of $Table_name table"	
		fi	
	    fi

      fi
       Data+="|"
      
      echo $Data > "$PWD/$Table_name"
      echo $Info >> "$PWD/.$Table_name"
      
      i+=1
      done
      echo "$Table_name Table Created succesfuly (:"
}
                    
            
#-------------------------- Drop Table funciotn -----------------------------

function Drop_Table {
  echo -e "Enter Name of Table:\c"
   read tab_name

  if [ -f "$PWD/$tab_name" ]
  then

   echo -e "Your sure to drop the $table_name table\n"

 select opt in "yes" "no"
   do
  case $opt in 
   "yes")    
    rm "$PWD/$tab_name" 2>$HOME/.error
    
    if [ $? -eq 0 ]
    then
    echo "the Table Dropped Successfully(:"
    fi 
    break 2>$HOME/.error ;;

   "no") break 2>$HOME/.error ;;
  esac
 done
else
   echo "the $tab_name doesn't exit"	
   
  fi 
}

#---------------------------- Update Table function ---------------------------------

function Table_update {

  read -p  "Enter The Table Name:" Table_name
 
    if [ -f $PWD/$Table_name ]
    then
  
     read -p "Enter Condition Column name:" Field_name
      res1=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$Field_name'") print i}}}' $PWD/$Table_name )

   
     if [[ $res1 == "" ]]
     then
	     
            echo "Field name Doesn't Exit"
            Table_Menu
     else
            read -p "Enter Value of Condition Column:" Value
     

        res2=$(cut -d'|' -f$res1 "$PWD/$Table_name" | grep  "^$Value$")
	
        if [[ $res2 == "" ]]
	then
		echo "the Value of Column Doesn't Exit"
		Table_Menu
	else	
         read -p "Enter Field Name: " Field
      
      res3=$(awk  'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$Field'") print i}}}' $PWD/$Table_name)
      if [[ $res3 == "" ]]
      then
        echo "Field name Doesn't Exit"
        Table_Menu
      else
        read -p "Enter new Value of Field:" Value_Field

	 Number_Record=$(cut -d'|' -f$res1 "$PWD/$Table_name" | grep -n "^$Value$"| cut -d':' -f1)

        Current_data=$(awk  -F'|' '{if(NR=='$Number_Record'){for(i=1;i<=NF;i++){if(i=='$res3') print $i}}}' $PWD/$Table_name 2>>$HOME/.errors)

        sed -i ''$Number_Record's/'$Current_data'/'$Value_Field'/g' "$PWD/$Table_name" 2>>$HOME/.errors
        echo "Row Updated Successfully"
        Table_Menu
      fi
    fi
  fi
else
	echo "Table Doesn't Exit"
	Table_update
    fi
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
		      row="$row$Usr_Data|"
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

#---------------------------------- Delete ----------------------------------

function Delete {
    read -p "Enter Table name: " table_name
     
    if [[ -f "$table_name" ]] 
    then
        cat "$table_name"

        read -p "Enter the column name to identify the record: " delete_column

	col_name=$(awk -F'|' '{if(NR==1)for(i=1;i<=NF;i++){if($i=="'$delete_column'") {print i}}}' "$table_name")

	if [[ $col_name == "" ]]
	then
		echo "The column you enntered not found in $table_name!"
		read -p "Enter the column name to identify the record: " delete_colum
	else
        	read -p "Enter the value to delete a record in $delete_column: " delete_value
	fi

	val_to_del=$(cut -d'|' -f$col_name "$table_name" | grep -n "^$delete_value$" | cut -d: -f1)
	if ! [[ "$val_to_del" == "" ]]
	then
            if (( $(echo "$val_to_del" | wc -l) > 1 ))
	    then
			echo "Multiple occurrences of $delete_column = $delete_value found, Please choose which row to delete: "
			awk -F'|' -v col="$col_name" -v val="$delete_value" '$col == val {print NR, $0}' "$table_name"
                	read -p "Enter the line number to delete: " chosen_row

                	sed -i ''$chosen_row'd' "$table_name" 2>$HOME/./errors
                	echo "Row $chosen_row with $delete_column = $delete_value deleted successfully."

            else
		sed -i ''$val_to_del'd' "$table_name" 2>$HOME/./errors
		echo "value of $delete_value deleted successfuly :)"
	    fi

	else
		echo "Record with $delete_column = $delete_value not found in $table_name."
	fi

    else
	echo "File $table_name does not exist!"
    fi
}




#---------------------------- Select Menu ------------------------------

function Select_Menu
{
echo "--------- SELECT MENU ----------"
echo "* 1. Select All Data           *"
echo "* 2. Select Specific record    *"
echo "* 3. Select Specific column    *"
echo "* 4. Back to table menu        *"
echo "* 5. Back to main menu         *"
echo "* 6. Exit                      *"
echo "--------------------------------"

    read -p "Enter your choice :" choice
    case $choice in
        1) Select_all_data
            ;;
        2) Select_specific_row
            ;;
        3) Select_specific_column 
            ;;
        4) clear; Table_Menu
	    ;;
        5) clear; Welcome; Print_Menu  
	    ;;
        6) exit 1
	    ;;
        *) echo "Invalid choice"; Select_Menu
            ;;
    esac

}


function Select_all_data {
    read -p "Enter Name of Table:" Table_name

    if [ -f "$PWD/$Table_name" ]
    then
        awk 'NR > 1 { print }' "$PWD/$Table_name" |grep -n "|"
	Select_Menu
    else
        echo "$Table_name Doesn't Exist"
        Select_all_data
    fi
}

 


function Select_specific_row {
    read -p "Enter The Table Name:" Table_name

    if [ -f "$PWD/$Table_name" ] 
    then
        read -p "Enter Condition Column name:" Field_name
        res1=$(awk 'BEGIN{FS="|"} NR==1{for(i=1;i<=NF;i++) if($i=="'$Field_name'") print i}' "$PWD/$Table_name")

        if [[  -z $res1 ]]
	then
            echo "Field name doesn't exist."
            Table_Menu
        else
            read -p "Enter Value of Condition Column:" Value

            res2=$(cut -d'|' -f$res1 "$PWD/$Table_name" | grep -n "^$Value$")
            if [[ -z $res2 ]]
	    then
                echo "The value of the condition column doesn't exist."
                Table_Menu
            else
                Number_Record=$(cut -d'|' -f$res1 "$PWD/$Table_name" | grep -n  "^$Value$" | cut -d':' -f1)
                data=$(awk 'NR=='$Number_Record' {print}' "$PWD/$Table_name")
                
                echo "Selected Row:"
                echo "$data"
                
                Select_Menu
            fi
        fi
    else
        echo "Table doesn't exist."
        Table_update
    fi
}

function Select_specific_column {
    read -p "Enter The Table Name:" Table_name

    if [ -f "$PWD/$Table_name" ]
    then
        read -p "Enter Condition Column name:" Field_name
        res1=$(awk 'BEGIN{FS="|"} NR==1{for(i=1;i<=NF;i++) if($i=="'$Field_name'") print i}' "$PWD/$Table_name")

        if [[ -z $res1 ]] 
	then
            echo "Field name doesn't exist."
            Table_Menu
        else
            read -p "Enter Value of Condition Column:" Value

	    res2=$(cut -d'|' -f"$res1" "$PWD/$Table_name" | grep -n "^$Value$")

	    
            if [[ -z $res2 ]]
	    then
                echo "The value of the condition column doesn't exist."
                Select_Menu
            else
		    cut -d'|' -f$res1 "$PWD/$Table_name" | grep -n "^$Value$"

                Select_Menu
             fi
        fi
    else
        echo "Table doesn't exist."
	Select_Menu
    fi
}



#----------------------- Cal Main Menu and welcome message Function ----------------------
Print_Menu # print menu
Welcome # Print welcome message
#---------------------------------------------------------------------

