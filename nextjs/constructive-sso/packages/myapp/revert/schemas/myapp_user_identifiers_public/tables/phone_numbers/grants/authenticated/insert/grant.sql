-- Revert: schemas/myapp_user_identifiers_public/tables/phone_numbers/grants/authenticated/insert/grant


REVOKE INSERT (cc, number, owner_id, is_primary, name) ON myapp_user_identifiers_public.phone_numbers FROM authenticated;


