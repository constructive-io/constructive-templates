-- Verify: schemas/routing_public/tables/apis/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.apis', 'INSERT', 'authenticated');