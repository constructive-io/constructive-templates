-- Verify: schemas/myapp_memberships_public/tables/org_member_profiles/indexes/org_member_profiles_entity_id_idx


SELECT assert_index('myapp_memberships_public.org_member_profiles_entity_id_idx'::regclass, 'myapp_memberships_public.org_member_profiles'::regclass, false);


