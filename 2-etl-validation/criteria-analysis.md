Criteria 1: The warehouse data must be made up of multiple data sources such that there are at least 4 sources that are independently produced.
- Yes, each of our 4 main data tables within the warehouse are coming from 4 different data sources:
    1. https://www.kaggle.com/datasets/shivamb/netflix-shows
    2. https://www.cs.cornell.edu/people/pabo/movie-review-data/?utm_source=chatgpt.com
    3. https://www.kaggle.com/datasets/kalilurrahman/top-box-office-revenue-data-english-movies?select=bomojobrandindices.csv
    4. https://www.kaggle.com/datasets/rounakbanik/the-movies-dataset?select=movies_metadata.csv

Criteria 2: The warehouse data must be composed of at least one source whose type is unstructured. This can be text, pdf, or images.
- Yes, we have used .txt values containing reviews as our unstructured datasource of choice.

Criteria 3: The warehouse data must be composed of multiple logical entities.
- Yes, our warehouse contains multiple entities:
    1. Movies
    2. Genres
    3. Countries
    4. Actors
    5. Production Companies

Criteria 4: The warehouse data must be consistent such that its functional dependencies hold within the records of a table and across records.
- Yes, here are some functional dependencies from the warehouse data:
    1. Movie names always map to the same genres
    2. Movies with the same name were mapped to unique genres and unique release dates

Criteria 5: There exists a table in the raw layer of the warehouse whose assigned data types do not best fit its domain of values.
- Yes, there exists columns within the tables in the raw layer of the warehouse with data types that do not BEST fit the domain of its values:
    1. Table: [netflix_movies_and_tvshows] Column: [date_added] Current Data Type: [STRING] Recommended Data Type: [TIMESTAMP/DATETIME]
    2. Table: [movies_metadata] Column: [adult] Current Data Type: [STRING] Recommended Data Type: [BOOLEAN]

Criteria 6: There exists a table in the raw layer of the warehouse whose null values are represented as empty strings, "\n" or something similar
- Yes, there exists a table in the raw layer of the warehouse whose null value is represented by "N/A":
    1. Table: [imdb_reviews] Column: [movie_name]

Criteria 7: There exists a table in the raw layer of the warehouse that stores the values of multiple attributes into a single field. These values represent distinct attributes, but they are packed into a single field.
- Yes, the mutiple genre values are stored into a single genre column instead of their own distinct columms:
    1. Table: [movies_metadata] Column: [genres]

Criteria 8: There exists a table in the raw layer of the warehouse that stores a list of elements in a cell.
- Yes –this happens when multiple values are stored in one cell instead of separate rows:
    1. movies_metadata.csv → The "genres" column stores: "[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}]"
    2. Instead of separate rows, genres are stored as lists inside a single cell. Thus, this criterion is fulfilled.

Criteria 9: There exists two tables in the raw layer of the warehouse which originated from different sources and which have similar data. These tables use two different identifier systems to refer to the same entity.
- Met – the results show that the same movie title appears with different movie_id values across datasets:
    1. "A Perfect Man" appears with movie_id = 2 in at least two different places.
    2. "Aftermath" appears under at least six different IDs.
    3. "Bad Boys" has four different IDs.
    4. This confirms that the same movie is being referenced with different unique identifiers across movies_metadata.csv and netflix_titles.csv.

Criteria 10: There exists a table in the raw layer of the warehouse that models more than one logical entity in the same table. This leads to data redundancy and storing repeated values. 
- Yes - some tables store multiple logical entities together, causing redundancy:
    1. In movies_metadata.csv, the same table contains:
    2. Movie information (title, release date)
    3. Company information (production company, distributor)
    4. Ideally, company information should be in a separate table, but it's mixed with movie metadata, fulfilling this criterion.

