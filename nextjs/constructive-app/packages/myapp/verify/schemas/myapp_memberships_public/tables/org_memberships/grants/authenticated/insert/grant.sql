-- Verify: schemas/myapp_memberships_public/tables/org_memberships/grants/authenticated/insert/grant


SELECT assert_table_grant('myapp_memberships_public.org_memberships'::regclass, 'authenticated', 'INSERT', ARRAY['actor_id', 'entity_id'], true);


