-- Deploy: schemas/myapp_auth_public/tables/principals/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


GRANT SELECT ON myapp_auth_public.principals TO authenticated;

