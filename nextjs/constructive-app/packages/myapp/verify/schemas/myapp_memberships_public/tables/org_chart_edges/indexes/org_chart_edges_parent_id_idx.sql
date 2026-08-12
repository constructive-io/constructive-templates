-- Verify: schemas/myapp_memberships_public/tables/org_chart_edges/indexes/org_chart_edges_parent_id_idx


SELECT assert_index('myapp_memberships_public.org_chart_edges_parent_id_idx'::regclass, 'myapp_memberships_public.org_chart_edges'::regclass, false);


