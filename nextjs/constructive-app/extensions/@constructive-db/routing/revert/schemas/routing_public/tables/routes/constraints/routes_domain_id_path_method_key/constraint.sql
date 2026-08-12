-- Revert: schemas/routing_public/tables/routes/constraints/routes_domain_id_path_method_key/constraint


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_domain_id_path_method_key RESTRICT;