/* Beginning of schema rough ideas */

/* Will lock this down later */
CREATE DATABASE orpdb1;
\connect orpdb1;
CREATE ROLE orp_user WITH LOGIN PASSWORD 'secretlater';
GRANT ALL PRIVILEGES ON DATABASE orpdb1 TO orp_user;
CREATE SCHEMA orp;

CREATE TABLE orp.admin (
  iAdminId SERIAL PRIMARY KEY
);

/* Any table can have an audit trail */
CREATE TABLE orp.audit (
  iAuditId SERIAL PRIMARY KEY,
  tTable VARCHAR(512),
  tMeta TEXT,
  dCreated TIMESTAMP,
  dModified TIMESTAMP,
  iCreatedId INTEGER REFERENCES orp.admin (iAdminId),
  iModifiedId INTEGER REFERENCES orp.admin (iAdminId)
);

/* May use some sort of oauth, this may change */
CREATE TABLE orp.login (
  iLoginId SERIAL PRIMARY KEY,
  tEmail VARCHAR(512),
  tPassword VARCHAR(1024)
);

/* Any person using the system */
CREATE TABLE orp.person (
  iPersonId SERIAL PRIMARY KEY,
  iLoginId INTEGER REFERENCES orp.login(iLoginId),
  iAdminId INTEGER REFERENCES orp.admin(iAdminId),
  bPrimary BOOLEAN,
  tFirstName VARCHAR(512),
  tLastName VARCHAR(512),
  dBirthDate DATE,
  tAddress1 TEXT,
  tAddress2 TEXT,
  tCity VARCHAR(512),
  tState VARCHAR(16),
  tZip VARCHAR(16)
);

/* Someone who has registered */
CREATE TABLE orp.registrant (
  iRegistrantId SERIAL PRIMARY KEY,
  iPersonId INTEGER REFERENCES orp.person(iPersonId),
  tType VARCHAR(32)
);

CREATE TABLE orp.form (
  iFormId SERIAL PRIMARY KEY,
  tName VARCHAR(512)
);

CREATE TABLE orp.formField (
  iFormFieldId SERIAL PRIMARY KEY,
  iFormId INTEGER REFERENCES orp.form(iFormId),
  tType VARCHAR(32),
  tText TEXT,
  iNumber NUMERIC
);

