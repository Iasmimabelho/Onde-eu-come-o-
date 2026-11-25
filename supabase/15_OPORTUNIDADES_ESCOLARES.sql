-- DADOS FICTÍCIOS: 15 oportunidades para demonstração escolar.
-- NÃO representam vagas reais nem inscrições externas.
-- Não altera nem exclui oportunidades existentes. Pode executar novamente sem duplicar.
-- Usa sua organização de demonstração já existente; se não existir, cria uma.
DO $$
DECLARE
  demo_org uuid := '33333333-3333-4333-8333-333333333333';
  admin_id uuid;
BEGIN
  SELECT id INTO admin_id FROM public.profiles WHERE role = 'admin' ORDER BY created_at LIMIT 1;
  IF admin_id IS NULL THEN
    RAISE EXCEPTION 'Nenhum perfil admin encontrado; nada foi inserido';
  END IF;
  INSERT INTO public.organizations (id, user_id, name, type, description, location, category, verified)
  VALUES (demo_org, admin_id, 'Oportunidades Simuladas — Projeto Escolar', 'instituicao',
          'Organização fictícia usada exclusivamente para demonstração do projeto escolar.',
          'Niterói, RJ', 'Demonstração', false)
  ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.opportunities
  (id, org_id, title, description, category, modality, location, requirements,
   skills_required, objectives_match, deadline, vacancies, status, is_free)
  VALUES
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000001', demo_org, 'Operador(a) de Caixa — Supermercado', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Atendimento ao público, operação de caixa e organização. Turnos combinados com a equipe.', 'emprego', 'presencial', 'Charitas, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['atendimento','vendas','organizacao']::text[], ARRAY['trabalho','oportunidades']::text[], CURRENT_DATE + 180, 6, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000002', demo_org, 'Repositor(a) de Mercadorias — Mercado', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Reposição, conferência de produtos e apoio ao estoque.', 'emprego', 'presencial', 'Alcântara, São Gonçalo, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['organizacao','logistica','atendimento']::text[], ARRAY['trabalho','oportunidades']::text[], CURRENT_DATE + 180, 7, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000003', demo_org, 'Auxiliar Administrativo — Escritório', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Planilhas, arquivos, agenda e suporte administrativo.', 'emprego', 'hibrido', 'Santa Rosa, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['administracao','excel','organizacao']::text[], ARRAY['trabalho','carreira']::text[], CURRENT_DATE + 180, 8, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000004', demo_org, 'Jovem Aprendiz — Administração', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Programa demonstrativo de aprendizagem em rotinas administrativas e atendimento.', 'programa', 'presencial', 'Centro, Rio de Janeiro, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['administracao','comunicacao','informatica']::text[], ARRAY['trabalho','estudar','oportunidades']::text[], CURRENT_DATE + 180, 9, 'ativo', true),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000005', demo_org, 'Assistente de Recursos Humanos', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Apoio a documentos, entrevistas e rotinas de pessoal.', 'emprego', 'hibrido', 'Fonseca, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['administracao','comunicacao','organizacao']::text[], ARRAY['trabalho','carreira']::text[], CURRENT_DATE + 180, 10, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000006', demo_org, 'Auxiliar de Laboratório de Química', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Organização de materiais, registro de amostras e apoio supervisionado em laboratório.', 'emprego', 'presencial', 'Maracanã, Rio de Janeiro, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['quimica','laboratorio','organizacao']::text[], ARRAY['trabalho','carreira']::text[], CURRENT_DATE + 180, 11, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000007', demo_org, 'Curso Introdutório de Química Aplicada', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Introdução demonstrativa a soluções, misturas e segurança em laboratório.', 'curso', 'remoto', 'Online', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['quimica','ciencias','laboratorio']::text[], ARRAY['estudar','oportunidades']::text[], CURRENT_DATE + 180, 12, 'ativo', true),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000008', demo_org, 'Bolsa de Formação em Análises Químicas', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Bolsa fictícia de formação inicial em análise de amostras e boas práticas.', 'bolsa', 'presencial', 'Ingá, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['quimica','laboratorio','ciencias']::text[], ARRAY['estudar','carreira']::text[], CURRENT_DATE + 180, 13, 'ativo', true),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000009', demo_org, 'Suporte Técnico de Informática — Júnior', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Instalação de programas, atendimento a chamados e manutenção básica.', 'emprego', 'hibrido', 'Itaipu, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['informatica','atendimento','logica']::text[], ARRAY['trabalho','tecnologia','carreira']::text[], CURRENT_DATE + 180, 14, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000010', demo_org, 'Curso de Excel e Informática para Trabalho', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Planilhas, documentos, e-mail profissional e ferramentas digitais.', 'curso', 'remoto', 'Online', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['informatica','excel','administracao']::text[], ARRAY['estudar','tecnologia','trabalho']::text[], CURRENT_DATE + 180, 15, 'ativo', true),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000011', demo_org, 'Introdução à Programação Web', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] HTML, CSS, JavaScript e projetos simples para portfólio.', 'curso', 'remoto', 'Online', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['programacao','informatica','logica']::text[], ARRAY['estudar','tecnologia','carreira']::text[], CURRENT_DATE + 180, 16, 'ativo', true),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000012', demo_org, 'Auxiliar de Logística e Estoque', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Conferência de pedidos, inventário e apoio na expedição.', 'emprego', 'presencial', 'Neves, São Gonçalo, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['logistica','organizacao','excel']::text[], ARRAY['trabalho','carreira']::text[], CURRENT_DATE + 180, 17, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000013', demo_org, 'Atendente de Farmácia — Iniciante', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Atendimento e organização de produtos, sem atribuições privativas de farmacêutico.', 'emprego', 'presencial', 'Icaraí, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['atendimento','comunicacao','organizacao']::text[], ARRAY['trabalho','oportunidades']::text[], CURRENT_DATE + 180, 18, 'ativo', false),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000014', demo_org, 'Oficina de Marketing e Redes Sociais', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Planejamento de posts, conteúdo e comunicação digital.', 'curso', 'remoto', 'Online', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['marketing','design','comunicacao']::text[], ARRAY['estudar','negocio','tecnologia']::text[], CURRENT_DATE + 180, 19, 'ativo', true),
  ('bbbbbbbb-bbbb-4bbb-8bbb-000000000015', demo_org, 'Voluntariado em Educação Comunitária', '[DEMONSTRAÇÃO ESCOLAR — OPORTUNIDADE FICTÍCIA] Apoio em oficinas educativas e organização de atividades comunitárias.', 'voluntariado', 'hibrido', 'Piratininga, Niterói, RJ', ARRAY['Oportunidade fictícia para testar o sistema de recomendações; não representa vaga real']::text[], ARRAY['comunicacao','organizacao','lideranca']::text[], ARRAY['oportunidades','estudar']::text[], CURRENT_DATE + 180, 20, 'ativo', true)
  ON CONFLICT (id) DO NOTHING;
END $$;

SELECT title, category, skills_required, objectives_match, deadline
FROM public.opportunities
WHERE id::text LIKE 'bbbbbbbb-bbbb-4bbb-8bbb-%'
ORDER BY category, title;
