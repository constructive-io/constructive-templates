-- Deploy: schemas/myapp_auth_public/tables/principals/columns/bypass_step_up/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/bypass_step_up/column


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN bypass_step_up SET NOT NULL;

