-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/indexes/principal_scope_overrides_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/created_at/column


CREATE INDEX principal_scope_overrides_created_at_idx ON myapp_auth_public.principal_scope_overrides ( created_at );

