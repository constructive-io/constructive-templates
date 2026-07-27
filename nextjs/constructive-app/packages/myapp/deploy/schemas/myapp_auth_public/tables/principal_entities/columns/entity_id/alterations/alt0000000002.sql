-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/entity_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/entity_id/column


COMMENT ON COLUMN myapp_auth_public.principal_entities.entity_id IS 'The organization this principal is scoped to';

