-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/grants/authenticated/update/grant


SELECT verify_table_grant('myapp_memberships_public.app_membership_defaults', 'UPDATE', 'authenticated');


