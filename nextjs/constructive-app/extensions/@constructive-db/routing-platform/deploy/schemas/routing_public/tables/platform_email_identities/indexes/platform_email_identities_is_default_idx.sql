-- Deploy: schemas/routing_public/tables/platform_email_identities/indexes/platform_email_identities_is_default_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table
-- requires: schemas/routing_public/tables/platform_email_identities/columns/is_default/column


CREATE UNIQUE INDEX platform_email_identities_is_default_idx ON routing_public.platform_email_identities (is_default) WHERE platform_email_identities.is_default = CAST('true' AS boolean);