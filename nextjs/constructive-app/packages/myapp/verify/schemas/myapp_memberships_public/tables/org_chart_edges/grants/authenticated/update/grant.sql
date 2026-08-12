-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_memberships_public.org_chart_edges'::regclass, 'authenticated', 'UPDATE', NULL, true);


