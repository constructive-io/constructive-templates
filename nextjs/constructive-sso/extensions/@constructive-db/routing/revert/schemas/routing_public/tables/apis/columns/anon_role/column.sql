-- Revert: schemas/routing_public/tables/apis/columns/anon_role/column


ALTER TABLE routing_public.apis 
  DROP COLUMN anon_role RESTRICT;