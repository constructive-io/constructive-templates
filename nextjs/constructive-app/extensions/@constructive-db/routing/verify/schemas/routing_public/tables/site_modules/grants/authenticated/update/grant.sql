-- Verify: schemas/routing_public/tables/site_modules/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.site_modules', 'UPDATE', 'authenticated');