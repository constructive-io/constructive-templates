-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/indexes/phone_numbers_is_primary_idx


SELECT assert_index('myapp_user_identifiers_public.phone_numbers_is_primary_idx'::regclass, 'myapp_user_identifiers_public.phone_numbers'::regclass, true);


