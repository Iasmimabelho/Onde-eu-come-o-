-- Execute no Supabase SQL Editor APÓS cadastrar as oportunidades fictícias.
-- Cada oportunidade presencial/híbrida de demonstração recebe um bairro distinto.
-- Não altera a oportunidade NovaTech nem oportunidades reais.
BEGIN;
UPDATE public.opportunities SET location = 'Charitas, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000001' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Alcântara, São Gonçalo, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000002' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Santa Rosa, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000003' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Centro, Rio de Janeiro, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000004' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Fonseca, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000005' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Maracanã, Rio de Janeiro, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000006' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Ingá, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000008' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Itaipu, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000009' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Neves, São Gonçalo, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000012' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Icaraí, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000013' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
UPDATE public.opportunities SET location = 'Piratininga, Niterói, RJ' WHERE id = 'bbbbbbbb-bbbb-4bbb-8bbb-000000000015' AND description LIKE '[DEMONSTRAÇÃO ESCOLAR%';
COMMIT;
SELECT title, location FROM public.opportunities WHERE id::text LIKE 'bbbbbbbb-bbbb-4bbb-8bbb-%' ORDER BY title;
