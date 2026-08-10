-- Verify: schemas/myapp_memberships_public/tables/org_chart_edge_grants/table


SELECT assert_table('myapp_memberships_public.org_chart_edge_grants'::regclass, false, NULL);


