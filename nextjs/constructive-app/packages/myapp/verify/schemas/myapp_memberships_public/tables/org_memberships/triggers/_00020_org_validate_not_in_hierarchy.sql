-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00020_org_validate_not_in_hierarchy


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, '_00020_org_validate_not_in_hierarchy', 'myapp_memberships_private.org_membership_validate_not_in_hierarchy_tg'::regproc, 19);


