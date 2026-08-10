-- Deploy: schemas/myapp_storage_public/types/bucket_type/type
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema


CREATE TYPE myapp_storage_public.bucket_type AS ENUM ( 'public', 'private', 'temp' );

