-- Verify: schemas/routing_public/tables/apis/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.apis', 'SELECT', 'authenticated');