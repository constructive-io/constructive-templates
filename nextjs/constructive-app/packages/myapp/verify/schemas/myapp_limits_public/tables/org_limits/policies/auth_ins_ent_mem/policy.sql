-- Verify: schemas/myapp_limits_public/tables/org_limits/policies/auth_ins_ent_mem/policy


SELECT assert_policy('myapp_limits_public.org_limits'::regclass, 'auth_ins_ent_mem', 'INSERT', true, false, true);


