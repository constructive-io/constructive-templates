-- Deploy: schemas/routing_public/tables/platform_email_site_identities/columns/site_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_site_identities/table
-- requires: schemas/routing_public/tables/platform_email_site_identities/columns/site_id/column


ALTER TABLE routing_public.platform_email_site_identities 
  ALTER COLUMN site_id SET NOT NULL;