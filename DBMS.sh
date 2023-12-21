#!/bin/bash

#directry to store all database files 
mkdir Main 2>.error

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
        2) ls /home/mohamedtorkey/Main; Table_Menu
            ;;
        3) Drop_Table
            ;;
        4) echo "Insert Ionto Table"
            ;;
       5) echo "Select From Table"
            ;;
       6) echo "Delete From Table"
            ;;
       7) echo "update table"
           ;;
       8) break 2>> /home/mohamedtorkey/.error
            ;;
       *)echo "Invalid choice"
            ;;
    esac

}


function Creat_Table
{
  echo -e "Enter Your Table name:\c"
   read f_name 
   if [ -f "/home/mohamedtorkey/Main/$f_name" ]
    then
   echo "$f_name is already created ,please Enter the anther file" ; Creat_Table
   else
   touch "/home/mohamedtorkey/Main/$f_name"
    echo -e "$f_name Table is Created succesfuly(:\n"
   fi
    typeset -i NCols
    typeset -i i
    echo -e "Enter the number of columns:\c"
     read NUCols 
     i=1
     
           Data="" 
      until [ $i -gt $NUCols ]
       do
      echo -e "Enter the name of column $i:\c"
      read name_col
      opn="("
      sep=","
      cls=")"
      
         Data+=$name_col
	
      echo -e "Type of Column $name_col:\n"
       select ty_col in "int" "str"
         do
           case $ty_col in
           int ) ty_int="int";break;;
           str ) ty_str="str";break;;
           * ) echo "Wrong Choice" ;;
           esac
	 done    
	   Data+="($ty_col"
        
	
       if [ $ty_col = "int" ]
       then
	       echo -e "Do You make $name_col is Primary key?(Y/N):\c"
	        read chpk

		if [ $chpk = "Y" ]
		then
			Data+=",PK)|"
			echo "DONE"
		else
			Data+=")|"
			echo "Fail"
		fi	
                 
	        
	else
		Data+=")|"
      fi
      
      i+=1
      echo $Data > "/home/mohamedtorkey/Main/$f_name"
      done

       
 
	        
}
                    
            
           
function Drop_Table {
  echo -e "Enter Name of Table:\c"
  read tab_name
  rm  "/home/mohamedtorkey/Main/$tab_name" 2>.error
  if [ $? -eq 0 ]
  then
    echo "the Table Dropped Successfully(:"

  fi
  Table_Menu
}
Table_Menu
