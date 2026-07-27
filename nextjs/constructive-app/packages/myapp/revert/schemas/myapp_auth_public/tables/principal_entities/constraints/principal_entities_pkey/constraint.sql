-- Revert: schemas/myapp_auth_public/tables/principal_entities/constraints/principal_entities_pkey/constraint


ALTER TABLE myapp_auth_public.principal_entities 
  DROP CONSTRAINT principal_entities_pkey;


