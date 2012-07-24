<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Organismos;

/**
 * OrganismosRepository Repositorio de datos de la clase entity Organismos
 *
 * @author Jose Gabriel Gonzalez
 * 
 */
class OrganismosRepository extends EntityRepository {
    
    public function GuardarDatosDeOrganismo(Organismos $organismo, EntityManager $em){
        
        try{
            $em->persist($organismo);
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
    public function queryOrganismos($isSearch, $searchField, $searchParam, EntityManager $em){
        
        if($isSearch && $searchField!="" && $searchParam!=""){
            
            switch($searchField){
                case 'nombre':
                    $searchField = "o.nombreOrganismo";
                    break;
                case 'rif':
                    $searchField = "o.rif";
                    break;
                case 'sector':
                    $searchField = "o.sector";
                    break;
            }
            
            $searchParam = strtoupper($searchParam);
            
            $filter = $isSearch? " WHERE upper($searchField) LIKE '%$searchParam%' ":"";
            
            $dql = "SELECT o FROM ExpidianGlobalBundle:Organismos o $filter";
            $query = $em->createQuery($dql);
            
        }else{
            
            $dql = "SELECT o FROM ExpidianGlobalBundle:Organismos o ORDER BY o.idOrganismo";
            $query = $em->createQuery($dql);
            
        }
        
        //echo $query->getSQL();
        
        return $query;
    }

    
}