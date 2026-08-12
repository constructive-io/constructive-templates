-- Verify: schemas/routing_public/tables/rls_settings/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.rls_settings', 'UPDATE', 'authenticated');