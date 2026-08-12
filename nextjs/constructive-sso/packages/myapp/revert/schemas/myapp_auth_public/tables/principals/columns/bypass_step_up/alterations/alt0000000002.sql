-- Revert: schemas/myapp_auth_public/tables/principals/columns/bypass_step_up/alterations/alt0000000002


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN bypass_step_up DROP DEFAULT;


