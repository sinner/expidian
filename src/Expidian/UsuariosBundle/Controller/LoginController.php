<?php
/**
 * Es la clase almacenadora de controladores que administran los accesos a las aplicaciones.
 *
 * @author José Gabriel Gonzalez perez
 */
namespace Expidian\UsuariosBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Paises;
use Expidian\GlobalBundle\Entity\Estados;
use Expidian\GlobalBundle\Entity\LogsUsuarios;

use Expidian\UsuariosBundle\Controller\Session\SessionManager;

class LoginController extends Controller
{
    public function loginAction($estatus){
        
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        
        if($sm->getSession_is_open()){
            return $this->redirect($this->generateUrl('ExpInicio'));
        }else{
            
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>$estatus));
        }  
        
    }
    
    public function autenticacionAction(){
        
        $request = $this->getRequest();
        $session = $request->getSession();
        
        if ($request->getMethod()=='POST'){

            $sm = new SessionManager($session);
            $sm->readSession();

            if($sm->getSession_is_open()){

                return $this->redirect($this->generateUrl('ExpInicio'));

            }else{

                $usuario = $request->get('_username');
                $clave = $request->get('_password');
                
                if($usuario=='' || $clave==''){

                    return $this->redirect($this->generateUrl('ExpUsuariosLogin'));

                }else{

                    $em = $this->getDoctrine()->getEntityManager();
                    $usuario_obj = $em->getRepository('ExpidianGlobalBundle:Usuarios')->autenticarUsuario($usuario, $clave);

                    if ($usuario_obj) {
                        
                        $sm->openSession($usuario_obj);
                        $sm->readSession();
                        
                        $estatus = 'exitoso';
                        $urlredirect = $this->generateUrl('ExpInicio');
                        
                        $log_obj = new LogsUsuarios();
                        $resultado_log = $em->getRepository('ExpidianGlobalBundle:LogsUsuarios')->registrarAccion($log_obj, $usuario_obj, "El usuario con la C.I. $usuario_obj ha sido autenticado correctamente y ha ingresado al sistema.", strtoupper($estatus));
                                                                   
                    }else{
                        
                        $estatus = 'fallido';
                        $urlredirect = $this->generateUrl('ExpUsuariosLogin',array('estatus'=>$estatus));
                        
                    }
                }
                
                return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'autenticacion','estatus'=>$estatus, 'urlredirect'=>$urlredirect));
                
            }
        }else{
            return $this->redirect($this->generateUrl('ExpUsuariosLogin'));
        }
    }
    
    public function cerrarSessionAction(){
        
        $request = $this->getRequest();
        $session = $request->getSession();
        
        $sm = new SessionManager($session);
        $sm->endSession();
        
        if($sm->getSession_is_open()){
            
            return $this->redirect($this->generateUrl('ExpUsuariosLogin'));
        }else{
            return $this->redirect($this->generateUrl('ExpUsuariosLogin'));
        }
        
    }
}

?>
