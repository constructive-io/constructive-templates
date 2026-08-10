-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/triggers/_99990_org_edge_insert_sprt


SELECT assert_trigger('myapp_memberships_public.org_chart_edges'::regclass, '_99990_org_edge_insert_sprt', 'myapp_memberships_private.org_org_chart_edge_insert_tg'::regproc, 4);


