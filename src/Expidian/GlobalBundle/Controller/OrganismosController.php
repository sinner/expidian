<?php

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

/**
 * Description of OrganismosController
 *
 * @author Jose Gabriel Gonzalez
 */
class OrganismosController extends Controller {
    
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
            $breadcrumb = array(array('text'=>'Organismos','url'=>$this->generateUrl('ExpOrganismosList')),array('text'=>'Lista','url'=>''));
            
            $em = $this->getDoctrine()->getEntityManager();
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                $isSearch = false; 
                $searchField = ""; 
                $searchOper = ""; 
                $searchString = ""; 
                $direction = "ASC"; 
                $sort = "o.idOrganismo"; 
                $rows = "10"; 
                $page = "1";
                return $this->render('ExpidianGlobalBundle:Organismos:list_organismos.html.twig', array('breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'is_search'=>$isSearch, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'direction'=>$direction, 'sort'=>$sort, 'rows'=>$rows, 'page'=>$page));
            }else{
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
            }
        }else{
            $estatus = "inicio";
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>$estatus));
        } 
    }
    
    /**
     * Renderiza la lista de Organismos
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
                
                $query = $em->getRepository('ExpidianGlobalBundle:Organismos')->queryOrganismos($isSearch, $searchField, $searchString, $em);
                
                $paginator = $this->get('knp_paginator');
                $pagination = $paginator->paginate(
                    $query,
                    $page/*page number*/,
                    10/*rows limit per page, you can use the $rows variable*/
                );
                
                return $this->render('ExpidianGlobalBundle:Ajax:table_list_organismos.html.twig', array('pager'=>$pagination,'is_search'=>$isSearch, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'direction'=>$direction, 'sort'=>$sort, 'rows'=>$rows, 'page'=>$page));
                
            }
            
        }
        
        $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde.';
        $class_style = 'errorDialogBox';
        
        return new Response("<div class='$class_style' style='margin: 20px 1.3% 10px;' ><p>$msj</p></div>");
    }
    
}

?>
