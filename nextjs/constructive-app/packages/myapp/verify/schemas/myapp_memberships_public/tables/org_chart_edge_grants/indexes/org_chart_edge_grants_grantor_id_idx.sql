-- Verify: schemas/myapp_memberships_public/tables/org_chart_edge_grants/indexes/org_chart_edge_grants_grantor_id_idx


SELECT assert_index('myapp_memberships_public.org_chart_edge_grants_grantor_id_idx'::regclass, 'myapp_memberships_public.org_chart_edge_grants'::regclass, false);


