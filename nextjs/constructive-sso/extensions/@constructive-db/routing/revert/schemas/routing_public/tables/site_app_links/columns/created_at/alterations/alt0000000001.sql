-- Revert: schemas/routing_public/tables/site_app_links/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN created_at DROP DEFAULT;