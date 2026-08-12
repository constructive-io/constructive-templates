-- Revert: schemas/routing_public/tables/site_deep_links/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN id DROP DEFAULT;