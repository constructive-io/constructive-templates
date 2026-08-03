-- Verify: schemas/routing_public/tables/sites/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.sites', 'DELETE', 'authenticated');