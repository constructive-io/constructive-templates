-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/triggers/_00015_org_validate_active_member_insert


SELECT assert_trigger('myapp_memberships_public.org_chart_edges'::regclass, '_00015_org_validate_active_member_insert', 'myapp_memberships_private.org_org_chart_validate_active_member_tg'::regproc, 7);


