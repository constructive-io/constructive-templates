-- Verify: schemas/myapp_user_identifiers_public/tables/phone_numbers/indexes/phone_numbers_updated_at_idx


SELECT verify_index('myapp_user_identifiers_public.phone_numbers', 'phone_numbers_updated_at_idx');


