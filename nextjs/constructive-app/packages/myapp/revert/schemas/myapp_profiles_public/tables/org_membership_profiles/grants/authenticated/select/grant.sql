-- Revert: schemas/myapp_profiles_public/tables/org_membership_profiles/grants/authenticated/select/grant


REVOKE SELECT ON myapp_profiles_public.org_membership_profiles FROM authenticated;


