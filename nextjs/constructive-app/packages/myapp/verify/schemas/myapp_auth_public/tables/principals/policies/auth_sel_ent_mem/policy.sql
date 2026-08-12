-- Verify: schemas/myapp_auth_public/tables/principals/policies/auth_sel_ent_mem/policy


SELECT assert_policy('myapp_auth_public.principals'::regclass, 'auth_sel_ent_mem', 'SELECT', true, true, false);


