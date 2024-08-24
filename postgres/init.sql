CREATE DATABASE ejabberd_db;
CREATE USER ejabberd_user WITH ENCRYPTED PASSWORD 'yourpassword';
GRANT ALL PRIVILEGES ON DATABASE ejabberd_db TO ejabberd_user;