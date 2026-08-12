-- Revert: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_principal_id_entity_id_key/constraint


ALTER TABLE myapp_auth_public.principal_entities 
  DROP CONSTRAINT principal_entities_principal_id_entity_id_key;


