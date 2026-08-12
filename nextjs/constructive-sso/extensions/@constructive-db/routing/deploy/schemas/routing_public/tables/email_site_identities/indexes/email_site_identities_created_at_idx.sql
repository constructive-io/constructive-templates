-- Deploy: schemas/routing_public/tables/email_site_identities/indexes/email_site_identities_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_site_identities/table
-- requires: schemas/routing_public/tables/email_site_identities/columns/created_at/column


CREATE INDEX email_site_identities_created_at_idx ON routing_public.email_site_identities (created_at);