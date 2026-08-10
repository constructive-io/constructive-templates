-- Verify: schemas/myapp_memberships_public/tables/org_members/indexes/org_members_entity_id_idx


SELECT assert_index('myapp_memberships_public.org_members_entity_id_idx'::regclass, 'myapp_memberships_public.org_members'::regclass, false);


