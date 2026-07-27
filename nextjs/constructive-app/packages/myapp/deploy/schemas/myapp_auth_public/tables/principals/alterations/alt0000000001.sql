-- Deploy: schemas/myapp_auth_public/tables/principals/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


ALTER TABLE myapp_auth_public.principals 
  DISABLE ROW LEVEL SECURITY;

