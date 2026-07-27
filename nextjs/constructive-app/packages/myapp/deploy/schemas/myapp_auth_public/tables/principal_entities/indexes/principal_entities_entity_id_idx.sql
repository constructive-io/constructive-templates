-- Deploy: schemas/myapp_auth_public/tables/principal_entities/indexes/principal_entities_entity_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/entity_id/column


CREATE INDEX principal_entities_entity_id_idx ON myapp_auth_public.principal_entities USING BTREE ( entity_id );

