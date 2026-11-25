-- ONDE EU COMEÇO: notificações internas automáticas.
-- Execute no SQL Editor após SEGURANCA_ADMIN.sql. Não envia e-mails.
-- Revise com atenção antes de aplicar ao banco de produção.
CREATE OR REPLACE FUNCTION public.notify_platform_admins()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = '' AS $$
DECLARE
  admin_id uuid;
  event_title text;
  event_message text;
BEGIN
  IF TG_TABLE_NAME = 'applications' THEN
    IF TG_OP = 'INSERT' THEN
      event_title := 'Nova inscrição';
      event_message := 'Uma pessoa demonstrou interesse em uma oportunidade.';
    ELSIF NEW.status IS DISTINCT FROM OLD.status THEN
      INSERT INTO public.notifications(user_id, title, message, type, link)
      VALUES (NEW.user_id, 'Inscrição atualizada', 'Sua candidatura agora está: ' || NEW.status, 'info', '/dashboard');
      event_title := 'Status de inscrição atualizado';
      event_message := 'Uma candidatura foi atualizada para: ' || NEW.status;
    ELSE
      RETURN NEW;
    END IF;
  ELSIF TG_TABLE_NAME = 'profiles' THEN
    event_title := 'Novo usuário cadastrado';
    event_message := 'Um novo perfil foi criado na plataforma.';
  ELSIF TG_TABLE_NAME = 'organizations' THEN
    event_title := 'Nova organização';
    event_message := 'Uma organização foi cadastrada.';
  ELSIF TG_TABLE_NAME = 'opportunities' THEN
    event_title := 'Nova oportunidade';
    event_message := 'Uma oportunidade foi publicada.';
  ELSE
    RETURN NEW;
  END IF;

  FOR admin_id IN SELECT p.id FROM public.profiles p WHERE p.role = 'admin' LOOP
    INSERT INTO public.notifications(user_id, title, message, type, link)
    VALUES (admin_id, event_title, event_message, 'info', '/admin');
  END LOOP;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS notify_admin_new_application ON public.applications;
CREATE TRIGGER notify_admin_new_application AFTER INSERT OR UPDATE OF status ON public.applications
FOR EACH ROW EXECUTE FUNCTION public.notify_platform_admins();
DROP TRIGGER IF EXISTS notify_admin_new_profile ON public.profiles;
CREATE TRIGGER notify_admin_new_profile AFTER INSERT ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.notify_platform_admins();
DROP TRIGGER IF EXISTS notify_admin_new_organization ON public.organizations;
CREATE TRIGGER notify_admin_new_organization AFTER INSERT ON public.organizations
FOR EACH ROW EXECUTE FUNCTION public.notify_platform_admins();
DROP TRIGGER IF EXISTS notify_admin_new_opportunity ON public.opportunities;
CREATE TRIGGER notify_admin_new_opportunity AFTER INSERT ON public.opportunities
FOR EACH ROW EXECUTE FUNCTION public.notify_platform_admins();

-- Confira as notificações da administradora:
SELECT title, message, created_at FROM public.notifications
WHERE user_id = '0276fb66-ec9d-4295-b816-041169a34e2b'
ORDER BY created_at DESC LIMIT 20;
