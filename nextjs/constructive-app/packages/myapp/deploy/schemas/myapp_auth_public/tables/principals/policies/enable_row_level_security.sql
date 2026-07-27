-- Deploy: schemas/myapp_auth_public/tables/principals/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


ALTER TABLE myapp_auth_public.principals 
  ENABLE ROW LEVEL SECURITY;

