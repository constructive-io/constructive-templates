-- Verify: schemas/myapp_auth_public/tables/principals/policies/auth_sel_ent_mem/policy


SELECT verify_policy('auth_sel_ent_mem', 'myapp_auth_public.principals');


