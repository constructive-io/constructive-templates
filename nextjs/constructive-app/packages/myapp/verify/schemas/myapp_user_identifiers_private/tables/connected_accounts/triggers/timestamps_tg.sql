-- Verify: schemas/myapp_user_identifiers_private/tables/connected_accounts/triggers/timestamps_tg


SELECT assert_trigger('myapp_user_identifiers_private.connected_accounts'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


