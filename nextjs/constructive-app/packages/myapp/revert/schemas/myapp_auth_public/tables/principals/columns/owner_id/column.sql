-- Revert: schemas/myapp_auth_public/tables/principals/columns/owner_id/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN owner_id RESTRICT;


