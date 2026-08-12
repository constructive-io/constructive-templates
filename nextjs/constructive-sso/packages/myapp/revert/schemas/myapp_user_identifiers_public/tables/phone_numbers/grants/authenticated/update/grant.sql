-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/update/grant


REVOKE UPDATE (is_primary, name) ON myapp_user_identifiers_public.phone_numbers FROM authenticated;


