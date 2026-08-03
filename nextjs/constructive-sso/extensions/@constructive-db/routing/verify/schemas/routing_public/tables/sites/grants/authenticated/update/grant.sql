-- Verify: schemas/routing_public/tables/sites/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.sites', 'UPDATE', 'authenticated');