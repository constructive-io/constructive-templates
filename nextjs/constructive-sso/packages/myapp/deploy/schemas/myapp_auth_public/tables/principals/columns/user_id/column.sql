-- Deploy: schemas/myapp_auth_public/tables/principals/columns/user_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN user_id uuid;

