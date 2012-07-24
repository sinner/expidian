<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Expedientes;
use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Procesos;
use Expidian\GlobalBundle\Entity\Etapas;
use Expidian\GlobalBundle\Entity\ControlMovimientos;

/**
 * ExpedientesRepository Repositorio de datos de la clase entity Expedientes
 *
 * @author Jose Gabriel Gonzalez
 * 
 */
class ExpedientesRepository extends EntityRepository {
    
    
    public function GuardarDatosDeExpediente(Expedientes $expediente, \DateTime $fecha, EntityManager $em){
        
        try{
            $em->persist($expediente);
            $em->flush();
            $this->saveControlMovimiento($expediente, $fecha, $em);
            $result = true;
        }catch(Exception $e){
            $result = false;
        }
        
        return $result;
        
    }
    
    /**
     * @param Boolean $isSearch Será verdadero cuando se esté haciendo una busqueda en vez de listar a todos.
     * @param String $searchField Será el nombre del campo por el cual se efectuara una busqueda.
     * @param String $searchParam Sera el valor con el que debe coincidir el campo en la busqueda.
     */
    public function queryExpedientes($isSearch, $searchField, $searchParam, EntityManager $em){
        
        if($isSearch && $searchField!="" && $searchParam!=""){
            
            switch($searchField){
                case 'nombre':
                    $searchField = "e.nombre";
                    break;
                case 'codigo':
                    $searchField = "e.codigoActual";
                    break;
                case 'ci_asignado':
                    $searchField = "u.usuario";
                    break;
            }
            
            $searchParam = strtoupper($searchParam);
            
            $filter = $isSearch? " WHERE upper($searchField) LIKE '%$searchParam%' ":"";
            
            $dql = "SELECT e, h, u, t, p, o FROM ExpidianGlobalBundle:Expedientes e JOIN e.etapaActual t JOIN e.procesoActual p JOIN e.organismo o JOIN e.usuarioAct u JOIN u.persona h $filter";
            $query = $em->createQuery($dql);
            
        }else{
            
            $dql = "SELECT e, h, u, t, p, o FROM ExpidianGlobalBundle:Expedientes e JOIN e.etapaActual t JOIN e.procesoActual p JOIN e.organismo o JOIN e.usuarioAct u JOIN u.persona h ORDER BY e.idExpediente";
            $query = $em->createQuery($dql);
            
        }
        
        //echo $query->getSQL();
        
        return $query;
    }
    
    /**
     *
     * @param EntityManager $em
     * @param Expedientes $exp
     * @param \DateTime $fecha
     * @return \Expidian\GlobalBundle\Entity\ControlMovimientos 
     */
    public function saveControlMovimiento(Expedientes $exp, \DateTime $fecha, EntityManager $em){
        
        $controlMov = new ControlMovimientos();
        $controlMov->setIdExpidiente($exp);
        $controlMov->setCodExpediente($exp->getCodigoActual());
        $controlMov->setFechaMovimiento($fecha);
        $controlMov->setIdAbogadoAsign($exp->getUsuarioAct());
        $controlMov->setIdAbogadoCoord($exp->getUsuarioIni());
        $controlMov->setIdEtapa($exp->getEtapaActual());
        $controlMov->setIdProceso($exp->getProcesoActual());
        
        $em->persist($controlMov);
        $em->flush();
        
        return $controlMov;
    }
    
}