-- Deploy: schemas/routing_public/tables/platform_email_site_identities/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_site_identities/table


ALTER TABLE routing_public.platform_email_site_identities 
  ADD COLUMN updated_at timestamptz;