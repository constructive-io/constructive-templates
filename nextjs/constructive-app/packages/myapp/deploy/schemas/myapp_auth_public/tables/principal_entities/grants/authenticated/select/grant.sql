-- Deploy: schemas/myapp_auth_public/tables/principal_entities/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


GRANT SELECT ON myapp_auth_public.principal_entities TO authenticated;

