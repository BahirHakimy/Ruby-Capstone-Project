CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    genre_id INT,
    author_id INT,
    source_id INT,
    label_id INT,
    publish_date date,
    archived BOOLEAN
);

ALTER TABLE item ADD CONSTRAINT fk_genre
  FOREIGN KEY(genre_id) REFERENCES genre(id);
ALTER TABLE item ADD CONSTRAINT fk_auhor
  FOREIGN KEY(auhor_id) REFERENCES auhor(id);
ALTER TABLE item ADD CONSTRAINT fk_source
  FOREIGN KEY(source_id) REFERENCES source(id);
ALTER TABLE item ADD CONSTRAINT fk_label
  FOREIGN KEY(label_id) REFERENCES label(id);

CREATE TABLE genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(55)
);

CREATE TABLE music_album(
    item_id INT NOT NULL,
    on_spotify BOOLEAN,
    PRIMARY KEY (item_id)
);

ALTER TABLE music_album ADD CONSTRAINT fk_item
  FOREIGN KEY (item_id) REFERENCES item(id);

  CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  genre VARCHAR(255),
  author_id INT,
  source VARCHAR(255),
  label VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN,
  multiplayer BOOLEAN,
  last_played_at DATE
);

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  publisher VARCHAR(255) NOT NULL,
  cover_state VARCHAR(255) NOT NULL,
  publish_date DATE NOT NULL
);

CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL
);

CREATE TABLE book_labels (
  book_id INTEGER REFERENCES books(id),
  label_id INTEGER REFERENCES labels(id),
  PRIMARY KEY (book_id, label_id)
);
