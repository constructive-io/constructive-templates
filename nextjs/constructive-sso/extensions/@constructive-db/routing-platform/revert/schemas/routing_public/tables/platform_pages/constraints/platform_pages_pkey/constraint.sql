-- Revert: schemas/routing_public/tables/platform_pages/constraints/platform_pages_pkey/constraint


ALTER TABLE routing_public.platform_pages 
  DROP CONSTRAINT platform_pages_pkey RESTRICT;