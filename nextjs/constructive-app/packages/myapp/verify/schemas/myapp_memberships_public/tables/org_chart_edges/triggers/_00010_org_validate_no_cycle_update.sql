-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/triggers/_00010_org_validate_no_cycle_update


SELECT assert_trigger('myapp_memberships_public.org_chart_edges'::regclass, '_00010_org_validate_no_cycle_update', 'myapp_memberships_private.org_org_chart_validate_no_cycle_tg'::regproc, 19);


