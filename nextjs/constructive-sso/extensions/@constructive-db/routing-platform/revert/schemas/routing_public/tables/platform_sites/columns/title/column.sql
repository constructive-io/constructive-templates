-- Revert: schemas/routing_public/tables/platform_sites/columns/title/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN title RESTRICT;