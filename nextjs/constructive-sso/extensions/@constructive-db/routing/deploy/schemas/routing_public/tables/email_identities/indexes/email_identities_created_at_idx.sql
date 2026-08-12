-- Deploy: schemas/routing_public/tables/email_identities/indexes/email_identities_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_identities/columns/created_at/column


CREATE INDEX email_identities_created_at_idx ON routing_public.email_identities (created_at);