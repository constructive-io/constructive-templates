-- Verify: schemas/routing_public/tables/hostname_bindings/indexes/hostname_bindings_domain_id_idx


SELECT verify_index('routing_public.hostname_bindings', 'hostname_bindings_domain_id_idx');