# TEST THE CONNECTION TO POSTGRESQL SERVER ON LOCALHOST

# LIBRARIES AND MODULES
import psycopg2  # For PostgreSQL

# Propetries of the connection string
database = "metsastys"
user = "postgres"
password = "Q2werty"
host = "localhost"
port = "5432"

# Trying to establish a connection to DB server
try:
    # Create a connection object
    dbaseconnection = psycopg2.connect(database=database, user=user, password=password,
                                       host=host, port=port)

    # Create a cursor to execute commands and retrieve result set
    cursor = dbaseconnection.cursor()
    cursor.execute("SELECT version();") # Executes version function on PG server and store result
    version_number = cursor.fetchone() # Read result from cursor (1 row)
    print("PostgreSQL:n versionumero on ", version_number)

# Throw an error if connection or cursor creation fails    
except (Exception, psycopg2.Error) as e:
    print("Tietokantayhteydessä tapahtui virhe", e) 

# If or if not successfull close the cursor and the connection    
finally:
    if (dbaseconnection):
        cursor.close()
        dbaseconnection.close()
        print("Yhteys tietokantaan katkaistiin")
