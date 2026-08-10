-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/policies/auth_upd_ent_mem/policy


SELECT assert_policy('myapp_memberships_public.org_chart_edges'::regclass, 'auth_upd_ent_mem', 'UPDATE', true, true, false);


