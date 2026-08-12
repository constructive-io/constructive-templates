-- Deploy: schemas/routing_public/tables/platform_email_site_identities/indexes/platform_email_site_identities_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_site_identities/table
-- requires: schemas/routing_public/tables/platform_email_site_identities/columns/updated_at/column


CREATE INDEX platform_email_site_identities_updated_at_idx ON routing_public.platform_email_site_identities (updated_at);