-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/policies/auth_del_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_chart_edges'::regclass, 'auth_del_ent_mem', 'DELETE', true, true, false);


