-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/owner_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/owner_id/column


COMMENT ON COLUMN myapp_auth_public.principal_entities.owner_id IS E'Denormalized owner_id from principals table for RLS';

