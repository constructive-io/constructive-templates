-- Verify: schemas/routing_public/tables/routes/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.routes', 'UPDATE', 'authenticated');