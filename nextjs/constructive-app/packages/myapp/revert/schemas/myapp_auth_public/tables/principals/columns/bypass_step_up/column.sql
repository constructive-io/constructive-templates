-- Revert: schemas/myapp_auth_public/tables/principals/columns/bypass_step_up/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN bypass_step_up RESTRICT;


