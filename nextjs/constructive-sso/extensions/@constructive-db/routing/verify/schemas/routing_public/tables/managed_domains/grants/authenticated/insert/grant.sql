-- Verify: schemas/routing_public/tables/managed_domains/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.managed_domains', 'INSERT', 'authenticated');