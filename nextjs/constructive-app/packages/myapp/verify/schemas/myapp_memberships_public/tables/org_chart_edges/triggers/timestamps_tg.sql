-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_chart_edges'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


