DROP TABLE IF EXISTS personagens;

CREATE TABLE personagens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    gender TEXT,
    hair_color TEXT,
     height TEXT, 
     homeworld TEXT, 
     mass TEXT, 
     name TEXT, 
     skin_color TEXT
);
