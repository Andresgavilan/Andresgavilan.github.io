-- Drop the existing table if it exists
DROP TABLE IF EXISTS data_Cv;

-- Create the new table
CREATE TABLE data_Cv (
    location TEXT,
    title TEXT,
    date text,
    city TEXT,
    subtitle TEXT,
    description TEXT,
    more_info TEXT,
    latitude FLOAT,
    longitude FLOAT
);

-- Import data from the CSV file into the table
COPY data_Cv (location, title, date, city, subtitle, description, more_info, latitude, longitude)
FROM 'C:/data/data.csv' DELIMITER ',' CSV HEADER QUOTE '"';

-- Verify the data
SELECT * FROM data_Cv;

INSERT INTO geo_data (location, title, date, city, subtitle, description, more_info, latitude, longitude)
SELECT d.location, d.title, d.date, d.city, d.subtitle, d.description, d.more_info, d.latitude, d.longitude
FROM data_Cv d
LEFT JOIN geo_data g
ON d.location = g.location AND d.latitude = g.latitude AND d.longitude = g.longitude
WHERE g.location IS NULL;

-- Verify the data in geo_data
SELECT * FROM geo_data;