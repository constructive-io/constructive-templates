-- Verify: schemas/routing_public/tables/site_modules/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.site_modules', 'INSERT', 'authenticated');