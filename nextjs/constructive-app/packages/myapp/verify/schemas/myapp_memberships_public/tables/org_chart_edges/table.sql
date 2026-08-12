-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/table


SELECT assert_table('myapp_memberships_public.org_chart_edges'::regclass, false, NULL);


