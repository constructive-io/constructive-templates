-- Revert: schemas/routing_public/tables/apis/columns/role_name/column


ALTER TABLE routing_public.apis 
  DROP COLUMN role_name RESTRICT;