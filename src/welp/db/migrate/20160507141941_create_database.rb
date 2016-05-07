class CreateDatabase < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE EXTENSION pgcrypto;
    SQL

    execute <<-SQL
    CREATE TABLE users (
      user_id			    Serial PRIMARY KEY,
      username        Varchar(20) UNIQUE NOT NULL,
      email			      Varchar(100) UNIQUE NOT NULL,
      passwd			   	Varchar(64) NOT NULL,
      date_sign_up		Varchar(100) NOT NULL,
      is_admin			  Boolean DEFAULT FALSE
    );
    SQL

    execute <<-SQL
    CREATE TABLE places (
      place_id			   Serial PRIMARY KEY,
      creator_id       Serial REFERENCES users (user_id),
      creation_date	   Timestamp,
      name			       Varchar(100) NOT NULL,
      street			     Varchar(64) NOT NULL,
      num				       Varchar(10) NOT NULL,
      zip				       TEXT NOT NULL,
      city			       Varchar(100) NOT NULL,
      longitude		     Real,
      latitude	       Real,
      phone		         Varchar(100),
      website			     Varchar(100)
    );
    SQL

    execute <<-SQL
    CREATE TABLE restaurants (
      place_id			Serial REFERENCES places,
      price_range	  Varchar(200),
      banquet		    Integer,
      take_out      Boolean,
      delivery	    Boolean,
      closed		    Bit(14)
    );
    SQL

    execute <<-SQL
    CREATE TABLE cafes (
      place_id     Serial REFERENCES places,
      Smoking		   Boolean,
      Snack		     Boolean
    );
    SQL

    execute <<-SQL
    CREATE TABLE hotels (
      place_id			            Serial REFERENCES places,
      num_stars                 Integer,
      num_rooms                 Integer,
      price_range_double_room 	Varchar(200)
    );
    SQL

    execute <<-SQL
    CREATE TABLE comments (
      place_id 			   Serial REFERENCES places,
      user_id				   Serial REFERENCES users,
      stars            Integer NOT NULL,
      text_comment 	   Text NOT NULL,
      creation_date 	 Timestamp NOT NULL,
      PRIMARY KEY (place_id, user_id,creation_date)
    );
    SQL

    execute <<-SQL
    CREATE TABLE tags (
      place_id 			Serial REFERENCES places,
      user_id				Serial REFERENCES users,
      name			    Varchar(100) UNIQUE NOT NULL,
      PRIMARY KEY (place_id, user_id)
    );
    SQL

  end

  def down
    execute <<-SQL
      DROP EXTENSION pgcrypt;
    SQL

    execute <<-SQL
      DROP TABLE users CASCADE;
      DROP TABLE places CASCADE;
      DROP TABLE restaurants CASCADE;
      DROP TABLE cafes CASCADE;
      DROP TABLE hotels CASCADE;
      DROP TABLE comments CASCADE;
      DROP TABLE tags CASCADE;
    SQL
  end
end