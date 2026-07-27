-- Verify: schemas/myapp_auth_public/tables/principal_entities/policies/auth_sel_dir_own/policy


SELECT verify_policy('auth_sel_dir_own', 'myapp_auth_public.principal_entities');


