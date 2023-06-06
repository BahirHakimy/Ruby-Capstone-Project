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