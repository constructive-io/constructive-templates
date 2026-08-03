-- Verify: schemas/routing_public/tables/http_routes/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.http_routes', 'UPDATE', 'authenticated');