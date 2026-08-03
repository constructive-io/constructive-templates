-- Revert: schemas/myapp_auth_public/tables/principals/constraints/principals_pkey/constraint


ALTER TABLE myapp_auth_public.principals 
  DROP CONSTRAINT principals_pkey;


