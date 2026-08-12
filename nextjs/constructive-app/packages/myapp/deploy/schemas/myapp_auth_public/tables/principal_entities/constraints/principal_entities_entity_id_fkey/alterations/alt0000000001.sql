-- Deploy: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_entity_id_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_entity_id_fkey/constraint


COMMENT ON CONSTRAINT principal_entities_entity_id_fkey ON myapp_auth_public.principal_entities IS E'@foreignFieldName scopedPrincipals';

