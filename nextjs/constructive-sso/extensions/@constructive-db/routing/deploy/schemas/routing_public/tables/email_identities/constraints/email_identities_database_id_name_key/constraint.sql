-- Deploy: schemas/routing_public/tables/email_identities/constraints/email_identities_database_id_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table


ALTER TABLE routing_public.email_identities 
  ADD CONSTRAINT email_identities_database_id_name_key 
    UNIQUE (database_id, name);