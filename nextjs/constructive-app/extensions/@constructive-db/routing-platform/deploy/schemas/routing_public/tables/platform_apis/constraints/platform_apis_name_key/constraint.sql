-- Deploy: schemas/routing_public/tables/platform_apis/constraints/platform_apis_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table


ALTER TABLE routing_public.platform_apis 
  ADD CONSTRAINT platform_apis_name_key 
    UNIQUE (name);