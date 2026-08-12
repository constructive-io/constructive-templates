-- Verify: schemas/myapp_memberships_public/tables/membership_types/table


SELECT assert_table('myapp_memberships_public.membership_types'::regclass, false, NULL);


