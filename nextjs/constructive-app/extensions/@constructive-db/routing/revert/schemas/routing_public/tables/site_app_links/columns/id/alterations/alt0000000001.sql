-- Revert: schemas/routing_public/tables/site_app_links/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN id DROP NOT NULL;