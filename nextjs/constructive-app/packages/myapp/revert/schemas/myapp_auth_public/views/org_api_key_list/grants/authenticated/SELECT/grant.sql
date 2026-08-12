-- Revert: schemas/myapp_auth_public/views/org_api_key_list/grants/authenticated/SELECT/grant


REVOKE SELECT ON myapp_auth_public.org_api_key_list FROM authenticated;


