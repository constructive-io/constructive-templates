-- Verify: schemas/myapp_memberships_private/trigger_fns/org_org_chart_edge_delete_tg


SELECT assert_function('myapp_memberships_private.org_org_chart_edge_delete_tg()'::regprocedure, 'TRIGGER'::regtype, false, true, 'VOLATILE');


