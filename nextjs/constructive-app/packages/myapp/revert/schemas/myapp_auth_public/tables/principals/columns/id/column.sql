-- Revert: schemas/myapp_auth_public/tables/principals/columns/id/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN id RESTRICT;


