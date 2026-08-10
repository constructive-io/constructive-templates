-- Verify: schemas/myapp_user_identifiers_public/tables/emails/triggers/emails_is_verified_monotonic_tg


SELECT assert_trigger('myapp_user_identifiers_public.emails'::regclass, 'emails_is_verified_monotonic_tg', 'utils.throw'::regproc, 19);


