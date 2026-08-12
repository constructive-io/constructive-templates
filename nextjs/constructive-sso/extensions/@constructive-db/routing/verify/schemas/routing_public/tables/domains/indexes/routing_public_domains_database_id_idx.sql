-- Verify: schemas/routing_public/tables/domains/indexes/routing_public_domains_database_id_idx


SELECT assert_index(CAST('routing_public.routing_public_domains_database_id_idx' AS regclass), CAST('routing_public.domains' AS regclass), false);