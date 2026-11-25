-- Execute no SQL Editor do Supabase após fazer backup.
-- Permite à empresa atualizar somente candidaturas de suas próprias oportunidades.
DROP POLICY IF EXISTS apps_org_update ON public.applications;
CREATE POLICY apps_org_update ON public.applications
FOR UPDATE TO authenticated
USING (EXISTS (
 SELECT 1 FROM public.opportunities o
 JOIN public.organizations org ON org.id = o.org_id
 WHERE o.id = applications.opportunity_id AND org.user_id = (SELECT auth.uid())
))
WITH CHECK (EXISTS (
 SELECT 1 FROM public.opportunities o
 JOIN public.organizations org ON org.id = o.org_id
 WHERE o.id = applications.opportunity_id AND org.user_id = (SELECT auth.uid())
));

-- Avisa o estudante dentro do site sempre que o status mudar.
-- E-mail externo requer integração com provedor de envio, não é enviado por este trigger.
CREATE OR REPLACE FUNCTION public.notify_student_application_status()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public
AS $$
DECLARE opportunity_title text;
DECLARE status_label text;
BEGIN
 IF NEW.status IS DISTINCT FROM OLD.status THEN
   SELECT title INTO opportunity_title FROM public.opportunities WHERE id = NEW.opportunity_id;
   status_label := CASE NEW.status
     WHEN 'aprovado' THEN 'aprovada'
     WHEN 'recusado' THEN 'recusada'
     WHEN 'em_analise' THEN 'em análise'
     WHEN 'inscrito' THEN 'inscrita'
     ELSE 'registrada como interesse' END;
   INSERT INTO public.notifications(user_id,title,message,type,link)
   VALUES (
     NEW.user_id,
     'Atualização da candidatura',
     'Sua candidatura para ' || coalesce(opportunity_title,'uma oportunidade') || ' foi ' || status_label || '.',
     CASE WHEN NEW.status = 'aprovado' THEN 'success' WHEN NEW.status = 'recusado' THEN 'warning' ELSE 'info' END,
     NULL
   );
 END IF;
 RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS notify_student_on_application_status ON public.applications;
CREATE TRIGGER notify_student_on_application_status
AFTER UPDATE OF status ON public.applications
FOR EACH ROW EXECUTE FUNCTION public.notify_student_application_status();
