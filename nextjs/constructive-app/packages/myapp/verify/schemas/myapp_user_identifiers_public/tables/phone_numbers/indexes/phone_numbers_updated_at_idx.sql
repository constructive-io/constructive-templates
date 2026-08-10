-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/indexes/phone_numbers_updated_at_idx


SELECT assert_index('myapp_user_identifiers_public.phone_numbers_updated_at_idx'::regclass, 'myapp_user_identifiers_public.phone_numbers'::regclass, false);


