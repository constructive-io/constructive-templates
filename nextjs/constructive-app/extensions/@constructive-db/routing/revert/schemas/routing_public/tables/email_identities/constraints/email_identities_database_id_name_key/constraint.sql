-- Revert: schemas/routing_public/tables/email_identities/constraints/email_identities_database_id_name_key/constraint


ALTER TABLE routing_public.email_identities 
  DROP CONSTRAINT email_identities_database_id_name_key RESTRICT;