-- Verify: schemas/routing_public/tables/managed_domains/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.managed_domains', 'DELETE', 'authenticated');