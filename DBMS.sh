#!/bin/bash

#directry to store all database files 
mkdir Main 2>.error


#*************************Table_Menu Opetions on Tables in Database**************************************

function Table_Menu
{
echo "***************************"
echo "*      Main Menu          *"
echo "***************************"
echo "* 1. Create Table         *"
echo "* 2. List Table           *"
echo "* 3. Drop Table           *"
echo "* 4. Insert Into Table    *"
echo "* 5. Select From Table    *"
echo "* 6. Delete From Table    *"
echo "* 7. Update Table         *"
echo "* 8. Exit                 *"
echo "***************************"

 echo -e "Enter your choice : \c"
  read choice
    case $choice in
        1) Creat_Table
            ;;
        2) ls $PWD/Main; Table_Menu
            ;;
        3) Drop_Table
            ;;
        4) echo "Insert Ionto Table"
            ;;
       5) Select_Menu
            ;;
       6) echo "Delete From Table"
            ;;
       7) Table_update
           ;;
       8) break 2>> $PWD/.errors
            ;;
       *)echo "Invalid choice"
            ;;
    esac

}

#************************Creat Table Functions**********************************

function Creat_Table
{
   read -p "Enter Your Table name:" Table_name
 
   if [ -f "$PWD/Main/$Table_name" ]
    then
         echo "$Table_name is already created ,please Enter the anther Name Table " ; Creat_Table

       else

          touch "$Table_name"
          touch "$Table_name"

          echo "$Table_name Table is Created succesfuly(:"
  fi

    typeset -i NC
    typeset -i i
    typeset -i j	

     j=1
    read -p "Enter the number of columns:" N_columns
     i=1
     Data="" 
	   
    until [ $i -gt $N_columns ]
     do
         read -p "Enter the name of column.$i:" Name_column
      
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
	        
	       read -p "Do You make $Name_column is Primary key?[y/n]:" check
	        

		if [ $check = "y" ]
		then
			Info+="|PK|"
		      j=2
		        echo "DONE"	
			
		fi	
	    fi

      fi
       Data+="|"
      
      echo $Data > "$PWD/Main/$Table_name"
      echo $Info >> "$PWD/Main/.$Table_name"
      


      i+=1
      done
    echo "The Data Compeleted successfully"  
 Table_Menu       
 
	        
}
                    
            
#**************************Drop Table funciotn**************************************************************

function Drop_Table {
  echo -e "Enter Name of Table:\c"
   read tab_name

  if [ -f "$PWD/Main/$tab_name" ]
  then

   echo -e "Your sure to drop the $table_name table\n"

 select opt in "yes" "no"
   do
  case $opt in 
   "yes")    
    rm "$PWD/Main/$tab_name" 2>.error
    
    if [ $? -eq 0 ]
    then
    echo "the Table Dropped Successfully(:"
    fi 
    break 2>.error ;;

   "no") break 2>.error ;;
  esac
 done
else
   echo "the $tab_name doesn't exit"	
   
  fi 

  Table_Menu
}

#***************************Update Table function*************************************************************


function Table_update {

  read -p  "Enter The Table Name:" Table_name
 
    if [ -f $PWD/Main/$Table_name ]
    then
  
     read -p "Enter Condition Column name:" Field_name
      res1=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$Field_name'") print i}}}' $PWD/Main/$Table_name )

   
     if [[ $res1 == "" ]]
     then
	     
            echo "Field name Doesn't Exit"
            Table_Menu
     else
            read -p "Enter Value of Condition Column:" Value
     

        res2=$(cut -d'|' -f$res1 "$PWD/Main/$Table_name" | grep  "^$Value$")
	
        if [[ $res2 == "" ]]
	then
		echo "the Value of Column Doesn't Exit"
		Table_Menu
	else	
         read -p "Enter Field Name: " Field
      
      res3=$(awk  'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$Field'") print i}}}' $PWD/Main/$Table_name)
      if [[ $res3 == "" ]]
      then
        echo "Field name Doesn't Exit"
        Table_Menu
      else
        read -p "Enter new Value of Field:" Value_Field

	 Number_Record=$(cut -d'|' -f$res1 "$PWD/Main/$Table_name" | grep -n "^$Value$"| cut -d':' -f1)

        Current_data=$(awk  -F'|' '{if(NR=='$Number_Record'){for(i=1;i<=NF;i++){if(i=='$res3') print $i}}}' $PWD/Main/$Table_name 2>>.errors)

        sed -i ''$Number_Record's/'$Current_data'/'$Value_Field'/g' "$PWD/Main/$Table_name" 2>>.errors
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

#*************************Select Menu********************************************

function Select_Menu
{
echo "********************************"
echo "*      SELECT MENU             *"
echo "********************************"
echo "* 1. Select All Data           *"
echo "* 2. Select Specific record    *"
echo "* 3. Select Specific column    *"
echo "********************************"

 read -p "Enter your choice :" choice
    case $choice in
        1) Select_all_data
            ;;
        2)Select_specific_row
            ;;
       3) Select_specific_column 
            ;;
       *)echo "Invalid choice"
            ;;
    esac

}


function Select_all_data {
    read -p "Enter Name of Table:" Table_name

    if [ -f "$PWD/Main/$Table_name" ]
    then
        awk 'NR > 1 { print }' "$PWD/Main/$Table_name" |grep -n "|"
	Select_Menu
    else
        echo "$Table_name Doesn't Exist"
        Select_all_data
    fi
}

 


function Select_specific_row {
    read -p "Enter The Table Name:" Table_name

    if [ -f "$PWD/Main/$Table_name" ] 
    then
        read -p "Enter Condition Column name:" Field_name
        res1=$(awk 'BEGIN{FS="|"} NR==1{for(i=1;i<=NF;i++) if($i=="'$Field_name'") print i}' "$PWD/Main/$Table_name")

        if [[  -z $res1 ]]
	then
            echo "Field name doesn't exist."
            Table_Menu
        else
            read -p "Enter Value of Condition Column:" Value

            res2=$(cut -d'|' -f$res1 "$PWD/Main/$Table_name" | grep -n "^$Value$")
            if [[ -z $res2 ]]
	    then
                echo "The value of the condition column doesn't exist."
                Table_Menu
            else
                Number_Record=$(cut -d'|' -f$res1 "$PWD/Main/$Table_name" | grep -n  "^$Value$" | cut -d':' -f1)
                data=$(awk 'NR=='$Number_Record' {print}' "$PWD/Main/$Table_name")
                
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

    if [ -f "$PWD/Main/$Table_name" ]
    then
        read -p "Enter Condition Column name:" Field_name
        res1=$(awk 'BEGIN{FS="|"} NR==1{for(i=1;i<=NF;i++) if($i=="'$Field_name'") print i}' "$PWD/Main/$Table_name")

        if [[ -z $res1 ]] 
	then
            echo "Field name doesn't exist."
            Table_Menu
        else
            read -p "Enter Value of Condition Column:" Value

	    res2=$(cut -d'|' -f$res1 "$PWD/Main/$Table_name" | grep -n "^$Value$")

	    
            if [[ -z $res2 ]]
	    then
                echo "The value of the condition column doesn't exist."
                Select_Menu
            else
                " cut -d'|' -f$res1 "$PWD/Main/$Table_name" | grep -n "^$Value$" "

                Select_Menu
             fi
        fi
    else
        echo "Table doesn't exist."
        Table_update
    fi
}



Table_Menu
