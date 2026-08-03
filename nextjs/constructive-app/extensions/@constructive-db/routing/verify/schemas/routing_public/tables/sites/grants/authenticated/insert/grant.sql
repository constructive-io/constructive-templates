-- Verify: schemas/routing_public/tables/sites/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.sites', 'INSERT', 'authenticated');