-- Verify: schemas/routing_public/tables/http_routes/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.http_routes', 'DELETE', 'authenticated');