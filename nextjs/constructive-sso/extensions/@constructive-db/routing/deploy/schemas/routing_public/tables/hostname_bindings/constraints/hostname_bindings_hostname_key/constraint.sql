-- Deploy: schemas/routing_public/tables/hostname_bindings/constraints/hostname_bindings_hostname_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table


ALTER TABLE routing_public.hostname_bindings 
  ADD CONSTRAINT hostname_bindings_hostname_key 
    UNIQUE (hostname);