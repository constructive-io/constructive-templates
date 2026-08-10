-- Revert: schemas/routing_public/tables/site_deep_links/columns/slug/alterations/alt0000000001


ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN slug DROP NOT NULL;