-- Deploy: schemas/routing_public/tables/platform_email_identities/indexes/platform_email_identities_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table
-- requires: schemas/routing_public/tables/platform_email_identities/columns/created_at/column


CREATE INDEX platform_email_identities_created_at_idx ON routing_public.platform_email_identities (created_at);