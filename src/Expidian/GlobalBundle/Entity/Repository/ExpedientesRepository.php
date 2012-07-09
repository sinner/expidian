<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Expedientes;

/**
 * ExpedientesRepository Repositorio de datos de la clase entity Expedientes
 *
 * @author Jose Gabriel Gonzalez
 * 
 */
class ExpedientesRepository extends EntityRepository {
    
    public function GuardarDatosDeExpediente(Expedientes $expediente, EntityManager $em){
        
        try{
            $em->persist($expediente);
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
    public function queryExpedientes($isSearch, $searchField, $searchParam, EntityManager $em){
        
        if($isSearch && $searchField!="" && $searchParam!=""){
            
            switch($searchField){
                case 'nombre':
                    $searchField = "e.nombre";
                    break;
                case 'rif':
                    $searchField = "e.codigoActual";
                    break;
            }
            
            $searchParam = strtoupper($searchParam);
            
            $filter = $isSearch? " WHERE upper($searchField) LIKE '%$searchParam%' ":"";
            
            $dql = "SELECT o FROM ExpidianGlobalBundle:Expedientes o $filter";
            $query = $em->createQuery($dql);
            
        }else{
            
            $dql = "SELECT o FROM ExpidianGlobalBundle:Expedientes o ORDER BY o.idExpediente";
            $query = $em->createQuery($dql);
            
        }
        
        //echo $query->getSQL();
        
        return $query;
    }

    
}