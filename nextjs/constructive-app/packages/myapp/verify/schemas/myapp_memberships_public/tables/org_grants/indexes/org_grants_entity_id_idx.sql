-- Verify: schemas/myapp_memberships_public/tables/org_grants/indexes/org_grants_entity_id_idx


SELECT assert_index('myapp_memberships_public.org_grants_entity_id_idx'::regclass, 'myapp_memberships_public.org_grants'::regclass, false);


