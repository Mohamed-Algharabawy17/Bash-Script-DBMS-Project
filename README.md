# Bash Shell Script Database Management System (DBMS)

## Overview

This project aims to develop a simple yet effective Database Management System (DBMS) using Bash Shell Scripting. The DBMS allows users to store, retrieve, and manage data on their hard disk through a Command Line Interface (CLI) menu.

## Features

### Main Menu

- **Create Database:** Create a new database to store tables.
- **List Databases:** View a list of available databases.
- **Connect To Database:** Connect to a specific database for further operations.
- **Drop Database:** Delete a database and its associated tables.

### Database Menu

After connecting to a specific database, the user is presented with additional options:

- **Create Table:** Define the structure of a new table, specifying column names and data types.
- **List Tables:** View a list of tables in the connected database.
- **Drop Table:** Remove a table from the database.
- **Insert Into Table:** Add new records to a table.
- **Select From Table:** Retrieve and display data from a table.
- **Delete From Table:** Remove records from a table based on specified conditions.
- **Update Table:** Modify existing records in a table.

### Hints

- Databases are stored as directories relative to the script file.
- Displayed rows from SELECT operations are formatted for easy readability.
- User input for column data types is validated during table creation, insertion, and updating.
- Primary keys can be defined during table creation and are enforced during data insertion.

## Usage

1. **Clone the repository:**

    ```bash
    git clone https://github.com/Mohamed-Algharabawy17/Bash-Script-DBMS-Project.git
    ```

2. **Navigate to the project directory:**

    ```bash
    cd dbms-shell-script
    ```

3. **Run the script:**

    ```bash
    ./dbms.sh
    ```

4. **Follow the on-screen instructions to interact with the DBMS.**

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
