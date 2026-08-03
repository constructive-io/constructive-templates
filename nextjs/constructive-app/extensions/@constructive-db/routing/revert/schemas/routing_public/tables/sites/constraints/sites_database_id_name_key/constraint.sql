-- Revert: schemas/routing_public/tables/sites/constraints/sites_database_id_name_key/constraint


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_database_id_name_key RESTRICT;