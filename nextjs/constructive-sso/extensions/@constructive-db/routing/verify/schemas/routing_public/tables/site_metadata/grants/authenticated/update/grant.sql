-- Verify: schemas/routing_public/tables/site_metadata/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.site_metadata', 'UPDATE', 'authenticated');