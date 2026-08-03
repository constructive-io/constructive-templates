-- Revert: schemas/routing_public/tables/apis/constraints/apis_database_id_name_key/constraint


ALTER TABLE routing_public.apis 
  DROP CONSTRAINT apis_database_id_name_key RESTRICT;