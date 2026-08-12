-- Revert: schemas/routing_public/tables/site_themes/columns/updated_at/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN updated_at RESTRICT;