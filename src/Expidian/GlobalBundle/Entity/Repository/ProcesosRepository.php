<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Procesos;

/**
 * ProcesosRepository Repositorio de datos de la clase entity Procesos
 *
 * @author Jose Gabriel Gonzalez
 * 
 */
class ProcesosRepository extends EntityRepository {
    
    public function GuardarDatosDeProceso(Procesos $Proceso, EntityManager $em){
        
        try{
            $em->persist($Proceso);
            $em->flush();
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
    public function queryProcesos($isSearch, $searchField, $searchParam, EntityManager $em){
        
        if($isSearch && $searchField!="" && $searchParam!=""){
            
            switch($searchField){
                case 'nombre':
                    $searchField = "p.proceso";
                    break;
                case 'consecutivo':
                    $searchField = "p.nroCsonsecutivoProceso";
                    break;
                case 'abrev':
                    $searchField = "p.procesoAbrev";
                    break;
            }
            
            $searchParam = strtoupper($searchParam);
            
            $filter = $isSearch? " WHERE upper($searchField) LIKE '%$searchParam%' ":"";
            
            $dql = "SELECT p FROM ExpidianGlobalBundle:Procesos p $filter";
            $query = $em->createQuery($dql);
            
        }else{
            
            $dql = "SELECT p FROM ExpidianGlobalBundle:Procesos p ORDER BY p.idProceso";
            $query = $em->createQuery($dql);
            
        }
        
        //echo $query->getSQL();
        
        return $query;
    }

    
}