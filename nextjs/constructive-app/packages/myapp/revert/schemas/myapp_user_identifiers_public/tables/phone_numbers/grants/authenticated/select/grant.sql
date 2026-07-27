-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/select/grant


REVOKE SELECT ON myapp_user_identifiers_public.phone_numbers FROM authenticated;


