-- Deploy: schemas/routing_public/tables/email_identities/indexes/email_identities_database_id_is_default_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_identities/columns/is_default/column
-- requires: schemas/routing_public/tables/email_identities/columns/database_id/column


CREATE UNIQUE INDEX email_identities_database_id_is_default_idx ON routing_public.email_identities (database_id, is_default) WHERE email_identities.is_default = CAST('true' AS boolean);