-- Verify: schemas/myapp_memberships_public/tables/org_chart_edge_grants/triggers/_00010_org_edge_grants_apply


SELECT assert_trigger('myapp_memberships_public.org_chart_edge_grants'::regclass, '_00010_org_edge_grants_apply', 'myapp_memberships_private.org_org_chart_edge_grants_apply_tg'::regproc, 5);


