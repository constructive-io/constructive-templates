-- Verify: schemas/routing_public/tables/apis/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.apis', 'UPDATE', 'authenticated');