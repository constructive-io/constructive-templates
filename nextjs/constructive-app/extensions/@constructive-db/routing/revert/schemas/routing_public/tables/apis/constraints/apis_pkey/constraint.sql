-- Revert: schemas/routing_public/tables/apis/constraints/apis_pkey/constraint


ALTER TABLE routing_public.apis 
  DROP CONSTRAINT apis_pkey RESTRICT;