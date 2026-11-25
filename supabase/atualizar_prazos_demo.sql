-- SOMENTE PARA OPORTUNIDADES DE DEMONSTRAÇÃO.
-- Confira os registros antes de executar. Não prorrogue vagas reais sem autorização.
SELECT id, title, deadline, status FROM public.opportunities
WHERE deadline < CURRENT_DATE ORDER BY deadline;

-- Execute separadamente, somente após confirmar que TODOS os registros selecionados são fictícios:
-- UPDATE public.opportunities
-- SET deadline = (CURRENT_DATE + INTERVAL '90 days')::date
-- WHERE status = 'ativo' AND deadline < CURRENT_DATE
--   AND id IN ('COLOQUE_AQUI_UM_UUID_DE_OPORTUNIDADE_DEMO');
