-- Revert: schemas/myapp_profiles_public/tables/org_profile_capabilities/grants/authenticated/select/grant


REVOKE SELECT ON myapp_profiles_public.org_profile_capabilities FROM authenticated;


