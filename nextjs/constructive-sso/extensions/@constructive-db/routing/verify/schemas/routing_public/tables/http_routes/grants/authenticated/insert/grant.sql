-- Verify: schemas/routing_public/tables/http_routes/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.http_routes', 'INSERT', 'authenticated');