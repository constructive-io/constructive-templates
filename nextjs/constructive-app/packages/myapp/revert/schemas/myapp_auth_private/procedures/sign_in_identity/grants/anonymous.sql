-- Revert: schemas/myapp_auth_private/procedures/sign_in_identity/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_private.sign_in_identity FROM anonymous;


