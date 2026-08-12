-- Verify: schemas/routing_public/tables/apis/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.apis', 'DELETE', 'authenticated');