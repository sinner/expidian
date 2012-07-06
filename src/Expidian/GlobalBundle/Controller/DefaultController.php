<?php

/**
 * Description of LoginController
 *
 * @author JGG-RDG
 */
namespace Expidian\GlobalBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Paises;
use Expidian\GlobalBundle\Entity\Estados;

use Expidian\UsuariosBundle\Controller\Session\SessionManager;

class DefaultController extends Controller
{
    public function indexAction()
    {
        $request = $this->getRequest();
        $session = $request->getSession();
        
        $sm = new SessionManager($session);
        $sm->readSession();
        
        $usuario_obj = $sm->getUsuario();
        
        //var_dump($usuario_obj);
        
        if($sm->getSession_is_open()){
            
            $breadcrumb = array(array('text'=>'Inicio','url'=>''));
            
            return $this->render('ExpidianGlobalBundle::inicio.html.twig', array('modulo'=>'Inicio','breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj,));
        }else{
            return $this->redirect($this->generateUrl('ExpUsuariosLogin'));
        }
    }
    
}

?>
