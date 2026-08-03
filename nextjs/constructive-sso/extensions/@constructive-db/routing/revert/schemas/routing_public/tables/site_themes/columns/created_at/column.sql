-- Revert: schemas/routing_public/tables/site_themes/columns/created_at/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN created_at RESTRICT;