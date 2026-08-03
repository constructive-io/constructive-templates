-- Deploy: schemas/myapp_auth_public/tables/principal_entities/indexes/principal_entities_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/updated_at/column


CREATE INDEX principal_entities_updated_at_idx ON myapp_auth_public.principal_entities ( updated_at );

