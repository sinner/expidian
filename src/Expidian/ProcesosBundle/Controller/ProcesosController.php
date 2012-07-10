<?php

namespace Expidian\ProcesosBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Paises;
use Expidian\GlobalBundle\Entity\Procesos;

use Expidian\GlobalBundle\Form\ProcesosType;

use Expidian\UsuariosBundle\Controller\Session\SessionManager;

/**
 * Description of ProcesosController
 *
 * @author Jose Gabriel Gonzalez
 */
class ProcesosController extends Controller {
    
    /**
     * Permite visualizar página inicial del módulo de Procesos.
     *  
     * @return Symfony\Component\HttpFoundation\Response
     */
    public function listAction() {
   
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        
        if($sm->getSession_is_open()){
            
            $usuario_obj = $sm->getUsuario();
            $breadcrumb = array(array('text'=>'Procesos','url'=>$this->generateUrl('ExpProcesosList')),array('text'=>'Lista','url'=>''));
            
            $em = $this->getDoctrine()->getEntityManager();
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                $isSearch = false; 
                $searchField = ""; 
                $searchOper = ""; 
                $searchString = ""; 
                $direction = "ASC"; 
                $sort = "o.idProceso"; 
                $rows = "10"; 
                $page = "1";
                return $this->render('ExpidianGlobalBundle:Procesos:list_procesos.html.twig', array('breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'is_search'=>$isSearch, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'direction'=>$direction, 'sort'=>$sort, 'rows'=>$rows, 'page'=>$page));
            }else{
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
            }
        }else{
            $estatus = "inicio";
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>$estatus));
        } 
    }
    
    /**
     * Renderiza la lista de Procesos
     * 
     * @return \Symfony\Component\HttpFoundation\Response 
     */
    public function ajaxListAction($page){
        
        $request = $this->getRequest();
        
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        
        if($sm->getSession_is_open()){
            
            $usuario_obj = $sm->getUsuario();
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                
                $em = $this->getDoctrine()->getEntityManager();
                
                $isSearch = $request->request->get('is_search');
                $rows = $request->request->get('rows');
                $searchField = $request->request->get('searchField');
                $searchOper = $request->request->get('searchOper');
                $searchString = $request->request->get('searchString');
                
                if($request->query->get('direction')==""){
                    $direction = $request->request->get('grid_direction'); // No es utilizado ya que el paginador de Knp lo provee
                }else{
                    $direction = $request->query->get('direction');
                }
                if($request->query->get('sort')==""){
                    $sort = $request->request->get('grid_sort'); // No es utilizado ya que el paginador de Knp lo provee
                }else{
                    $sort = $request->query->get('sort');             
                }
                
                //$page = $request->query->get('page'); // No es utilizado ya que el paginador de Knp lo provee
                
                $query = $em->getRepository('ExpidianGlobalBundle:Procesos')->queryProcesos($isSearch, $searchField, $searchString, $em);
                
                $paginator = $this->get('knp_paginator');
                $pagination = $paginator->paginate(
                    $query,
                    $page/*page number*/,
                    10/*rows limit per page, you can use the $rows variable*/
                );
                
                return $this->render('ExpidianGlobalBundle:Ajax:table_list_procesos.html.twig', array('pager'=>$pagination,'is_search'=>$isSearch, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'direction'=>$direction, 'sort'=>$sort, 'rows'=>$rows, 'page'=>$page));
                
            }
            
        }
        
        $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde.';
        $class_style = 'errorDialogBox';
        
        return new Response("<div class='$class_style' style='margin: 20px 1.3% 10px;' ><p>$msj</p></div>");
    }
    
    /**
     * Permite el Registro de un nuevo Proceso al Sistema. Si el método por el que se llama a esta función es "GET" se mostrará el formulario para el ingreso de los datos del nuevo proceso. Si el método es "POST" se validará el formulario y se procederá si la validación es exitosa al registro del nuevo proceso al sistema.
     * 
     * @return Symfony\Component\HttpFoundation\Response
     */
    public function newAction() {
        
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        $usuario_obj = $sm->getUsuario();
        
        if($sm->getSession_is_open()){
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                
                $breadcrumb = array(array('text'=>'Procesos','url'=>$this->generateUrl('ExpProcesosList')),array('text'=>'Nuevo','url'=>''));
                
                $proceso = new Procesos();
                
                $form = $this->createForm(new ProcesosType(),$proceso);
                
                //Si la petición viene por método post se reciben los datos del formulario se validan los mismos y se crea un nuevo usuario.
                if($request->getMethod()=='POST'){
                    
                    //Con esta sentencia vinculo los valores proporcionados por el formulario a cada uno de los atributos del objeto para que fué configurado. En este caso $usuario
                    $form->bindRequest($request);
                    $em = $this->getDoctrine()->getEntityManager();
                    
                    if($form->isValid()){
                                                
                        $result = $em->getRepository('ExpidianGlobalBundle:Procesos')->GuardarDatosDeProceso($proceso, $em);
                        
                        if($result){
                            $msj = 'El Proceso <b>'.$proceso->getNombreProceso().'</b> ha sido registrado exitosamente. Para agregar un nuevo proceso haga click <a href='.$this->generateUrl('ExpProcesosNew').'>aqu&iacute;</a>';
                            $class_style = 'successDialogBox';
                        }else{
                            $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde. Para agregar un nuevo proceso haga click <a href='.$this->generateUrl('ExpProcesosNew').'>aqu&iacute;</a>';
                            $class_style = 'errorDialogBox';
                        }
                        
                        return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>$msj, 'class'=>$class_style,'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                        
                    }
                    
                }

                return $this->render('ExpidianGlobalBundle:Procesos:edit_procesos.html.twig', array('form'=>$form->createView(), 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'opc'=>'Nuevo'));
                
            }else{
                
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                
            }
            
        }else{
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>''));
        } 
    }
    
    public function editAction($id_proceso) {
        
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        $usuario_obj = $sm->getUsuario();
        
        if($sm->getSession_is_open()){
            
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                
                $breadcrumb = array(array('text'=>'Procesos','url'=>$this->generateUrl('ExpProcesosList')),array('text'=>'Editar','url'=>''));
                                
                $em = $this->getDoctrine()->getEntityManager();
                $proceso = $em->getRepository('ExpidianGlobalBundle:Procesos')->find($id_proceso);
                
                $form = $this->createForm(new ProcesosType(),$proceso);
                
                //Si la petición viene por método post se reciben los datos del formulario se validan los mismos y se crea un nuevo proceso.
                if($request->getMethod()=='POST'){
                                        
                    //Con esta sentencia vinculo los valores proporcionados por el formulario a cada uno de los atributos del objeto para que fué configurado. En este caso $proceso
                    $form->bindRequest($request);
                    $em = $this->getDoctrine()->getEntityManager();
                    
                    if($form->isValid()){
                        
                        $result = $em->getRepository('ExpidianGlobalBundle:Procesos')->GuardarDatosDeProceso($proceso, $em);
                        
                        if($result){
                            $msj = 'Los Datos del Proceso <b>'.$proceso->getNombreProceso().'</b> han sido Editados Existosamente.';
                            $class_style = 'successDialogBox';
                        }else{
                            $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde. Para agregar un nuevo proceso haga click <a href='.$this->generateUrl('ExpProcesosNew').'>aqu&iacute;</a>';
                            $class_style = 'errorDialogBox';
                        }
                        
                        return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>$msj, 'class'=>$class_style,'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                        
                    }
                    
                }

                return $this->render('ExpidianGlobalBundle:Procesos:edit_procesos.html.twig', array('form'=>$form->createView(), 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'opc'=>'Editar'));
                
            }else{
                
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                
            }
            
            
            return $this->render('ExpidianUsuariosBundle:Usuarios:edit_usuarios.html.twig', array('form'=>$form->createView(), 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'opc'=>'Editar'));
            
        }else{
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>''));
        } 
        
    }
    
    public function deleteAction($id_usuario) {
        
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        
        if($sm->getSession_is_open()){
            
            $breadcrumb = array(array('text'=>'Usuarios','url'=>$this->generateUrl('ExpUsuariosList')),array('text'=>'Editar','url'=>''));
            
            $em = $this->getDoctrine()->getEntityManager();
            $usuario = $em->getRepository('ExpidianGlobalBundle:Usuarios')->find($id_usuario);
            
            $usuario_obj = $sm->getUsuario();
            
            return $this->render("");
            
        }else{
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>''));
        } 
        
    }
    
}

?>
