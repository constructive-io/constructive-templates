-- Revert: schemas/myapp_auth_public/tables/principals/grants/authenticated/select/grant


REVOKE SELECT ON myapp_auth_public.principals FROM authenticated;


