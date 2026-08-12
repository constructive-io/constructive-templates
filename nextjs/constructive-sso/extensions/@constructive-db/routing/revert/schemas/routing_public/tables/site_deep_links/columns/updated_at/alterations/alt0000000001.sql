-- Revert: schemas/routing_public/tables/site_deep_links/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN updated_at DROP DEFAULT;