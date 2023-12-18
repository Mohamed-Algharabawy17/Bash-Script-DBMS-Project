#!/bin/bash

mkdir Main 2>> /home/gharabawy/.errors

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
        1) CreateDB
                ;;
        2) ListDBS
                ;;
	3) OpenDB
		;;
	4) DropDB
		;;
	5) break 2>> /home/gharabawy/.errors; cd ~
		;;
        *) echo "Your choice $choice dosen't exist !"; Print_Menu
esac

}

#Print_Menu # print menu


#---------------------- Create Database -----------------------

function CreateDB {
	read -p "Enter Database name: " db_name
	mkdir /home/gharabawy/Main/$db_name 2>> /home/gharabawy/.errors
	if [[ $? == 0 ]]
	then
		echo "Database $db_name created successfuly ;)"
	else
		echo "The $db_name database is already exists"; CreateDB
	fi
	Print_Menu
}


#---------------------- List Databases -------------------------

function ListDBS {
	ls /home/gharabawy/Main
	Print_Menu
}


#--------------------- Connect to Database ----------------------

function OpenDB {
	read -p "Enter Database name: " db_name
	if [[ -d "/home/gharabawy/Main/$db_name" ]]
	then
		cd /home/gharabawy/Main/$db_name
		echo "Database $db_name opened successfuly :)"
	else
		echo "Database $db_name dosen't exist !"; OpenDB
	fi

	cd ~
	Print_Menu
}


#--------------------- Drop Database ----------------------------


function DropDB {
    read -p "Enter Database name: " db_name
    read -p "Are you sure? Answer yes or no: " confirm
    case $confirm in
        "yes" ) 
            if [ -d "/home/gharabawy/Main/$db_name" ]; then
                rm -r "/home/gharabawy/Main/$db_name"
                if [[ $? == 0 ]]; then 
                    echo "Database $db_name deleted successfully :)"
                else
                    echo "Failed to delete database $db_name."
                fi
            else
                echo "Database $db_name doesn't exist!"
            fi
            	;;
        "no" ) Print_Menu
		;;

        * ) echo "Invalid input Please answer yes or no."; DropDB 
		;;
    esac
    Print_Menu
}



Print_Menu # print menu
