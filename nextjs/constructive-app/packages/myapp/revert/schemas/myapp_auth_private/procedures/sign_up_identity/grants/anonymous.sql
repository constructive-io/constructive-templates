-- Revert: schemas/myapp_auth_private/procedures/sign_up_identity/grants/anonymous


REVOKE EXECUTE ON FUNCTION myapp_auth_private.sign_up_identity FROM anonymous;


