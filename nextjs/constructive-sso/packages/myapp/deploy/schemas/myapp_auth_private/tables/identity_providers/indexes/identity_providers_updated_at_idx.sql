-- Deploy: schemas/myapp_auth_private/tables/identity_providers/indexes/identity_providers_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_auth_private/tables/identity_providers/columns/updated_at/column


CREATE INDEX identity_providers_updated_at_idx ON myapp_auth_private.identity_providers ( updated_at );

