-- Revert: schemas/routing_public/tables/pages/constraints/pages_site_id_fkey/constraint


ALTER TABLE routing_public.pages 
  DROP CONSTRAINT pages_site_id_fkey RESTRICT;