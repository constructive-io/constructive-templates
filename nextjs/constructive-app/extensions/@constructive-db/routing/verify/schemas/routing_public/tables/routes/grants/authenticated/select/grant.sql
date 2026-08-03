-- Verify: schemas/routing_public/tables/routes/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.routes', 'SELECT', 'authenticated');