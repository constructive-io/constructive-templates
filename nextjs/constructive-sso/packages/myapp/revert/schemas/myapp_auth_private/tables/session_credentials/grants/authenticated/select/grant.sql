-- Revert: schemas/myapp_auth_private/tables/session_credentials/grants/authenticated/select/grant


REVOKE SELECT ON myapp_auth_private.session_credentials FROM authenticated;


