-- Revert: schemas/routing_public/tables/pages/constraints/pages_pkey/constraint


ALTER TABLE routing_public.pages 
  DROP CONSTRAINT pages_pkey RESTRICT;