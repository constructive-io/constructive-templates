-- Revert: schemas/myapp_auth_public/tables/principals/constraints/principals_owner_id_fkey/constraint


ALTER TABLE myapp_auth_public.principals 
  DROP CONSTRAINT principals_owner_id_fkey;


