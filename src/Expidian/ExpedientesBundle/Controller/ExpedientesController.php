<?php

namespace Expidian\ExpedientesBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Paises;
use Expidian\GlobalBundle\Entity\Organismos;
use Expidian\GlobalBundle\Entity\Expedientes;
use Expidian\GlobalBundle\Entity\ControlMovimientos;

use Expidian\GlobalBundle\Form\ExpedientesType;

use Expidian\UsuariosBundle\Controller\Session\SessionManager;

/**
 * Description of ExpedientesController
 *
 * @author Jose Gabriel Gonzalez
 */
class ExpedientesController extends Controller
{
    
    /**
     * Permite visualizar página inicial del módulo de Organismos.
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
            $breadcrumb = array(array('text'=>'Expedientes','url'=>$this->generateUrl('ExpExpedientesList')),array('text'=>'Lista','url'=>''));
            
            $em = $this->getDoctrine()->getEntityManager();
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Asignado'){
                $isSearch = false; 
                $searchField = ""; 
                $searchOper = ""; 
                $searchString = ""; 
                $direction = "ASC"; 
                $sort = "e.idExpediente"; 
                $rows = "10"; 
                $page = "1";
                return $this->render('ExpidianExpedientesBundle:Expedientes:list_expedientes.html.twig', array('breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'is_search'=>$isSearch, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'direction'=>$direction, 'sort'=>$sort, 'rows'=>$rows, 'page'=>$page));
            }else{
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
            }
        }else{
            $estatus = "inicio";
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>$estatus));
        } 
    }
    
    /**
     * Renderiza la lista de Expedientes
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
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Asignado'){
                
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
                
                $query = $em->getRepository('ExpidianGlobalBundle:Expedientes')->queryExpedientes($isSearch, $searchField, $searchString, $em);
                
                $paginator = $this->get('knp_paginator');
                $pagination = $paginator->paginate(
                    $query,
                    $page/*page number*/,
                    10/*rows limit per page, you can use the $rows variable*/
                );
                
                return $this->render('ExpidianExpedientesBundle:Ajax:table_list_expedientes.html.twig', array('pager'=>$pagination,'is_search'=>$isSearch, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'direction'=>$direction, 'sort'=>$sort, 'rows'=>$rows, 'page'=>$page));
                
            }
            
        }
        
        $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde.';
        $class_style = 'errorDialogBox';
        
        return new Response("<div class='$class_style' style='margin: 20px 1.3% 10px;' ><p>$msj</p></div>");
    }
    
    /**
     * Permite el Registro de un nuevo Expediente al Sistema. Si el método por el que se llama a esta función es "GET" se mostrará el formulario para el ingreso de los datos del nuevo Expediente. Si el método es "POST" se validará el formulario y se procederá si la validación es exitosa al registro del nuevo Expediente al sistema.
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
                
                $breadcrumb = array(array('text'=>'Expedientes','url'=>$this->generateUrl('ExpExpedientesList')),array('text'=>'Nuevo','url'=>''));
                
                $Expediente = new Expedientes();
                
                $form = $this->createForm(new ExpedientesType(),$Expediente);
                
                //Si la petición viene por método post se reciben los datos del formulario se validan los mismos y se crea un nuevo usuario.
                if($request->getMethod()=='POST'){
                    
                    //Con esta sentencia vinculo los valores proporcionados por el formulario a cada uno de los atributos del objeto para que fué configurado. En este caso $usuario
                    $form->bindRequest($request);
                    $em = $this->getDoctrine()->getEntityManager();
                                        
                    if(true){
                        
                        $etapaActual = $em->getRepository('ExpidianGlobalBundle:Etapas')->findEtapaInicial($em);
                        $usuarioAct = $em->getRepository('ExpidianGlobalBundle:Usuarios')->findOneByIdUsuario($usuario_obj->getIdUsuario());
                        $Expediente->setSesssionId($sm->getSessionId());
                        $Expediente->setUsuarioIni($usuarioAct);
                        $Expediente->setProcesoActual($etapaActual->getProceso());
                        $Expediente->setEtapaActual($etapaActual);
                        $codExp = $em->getRepository('ExpidianGlobalBundle:ControlMovimientos')->getCodigoExp($em,$etapaActual);
                        $Expediente->setCodigoActual($codExp);
                        
                        //var_dump($Expediente);
                        
                        $result = $em->getRepository('ExpidianGlobalBundle:Expedientes')->GuardarDatosDeExpediente($Expediente, $Expediente->getFechaRegistro(), $em);
                        
                        if($result){
                            $msj = 'El Expediente <b>'.$Expediente->getNombre().'</b> ha sido registrado Exitosamente. Para agregar un nuevo Expediente haga click <a href='.$this->generateUrl('ExpExpedientesNew').'>aqu&iacute;</a>';
                            $class_style = 'successDialogBox';
                        }else{
                            $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde. Para agregar un nuevo Expediente haga click <a href='.$this->generateUrl('ExpExpedientesNew').'>aqu&iacute;</a>';
                            $class_style = 'errorDialogBox';
                        }
                        
                        return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>$msj, 'class'=>$class_style,'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                        
                    }
                    
                }

                return $this->render('ExpidianExpedientesBundle:Expedientes:edit_expedientes.html.twig', array('form'=>$form->createView(), 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'opc'=>'Nuevo'));
                
            }else{
                
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                
            }
            
        }else{
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>''));
        } 
    }
    
}
