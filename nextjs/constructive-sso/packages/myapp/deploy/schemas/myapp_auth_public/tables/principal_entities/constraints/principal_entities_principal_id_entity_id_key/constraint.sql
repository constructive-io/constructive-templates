-- Deploy: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_principal_id_entity_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_principal_id_entity_id_key 
    UNIQUE (principal_id, entity_id);

