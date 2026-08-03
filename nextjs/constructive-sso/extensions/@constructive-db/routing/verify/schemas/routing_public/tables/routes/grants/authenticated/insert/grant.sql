-- Verify: schemas/routing_public/tables/routes/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.routes', 'INSERT', 'authenticated');