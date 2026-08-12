-- Revert: schemas/routing_public/tables/site_app_links/columns/app_identifier/alterations/alt0000000001


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN app_identifier DROP NOT NULL;