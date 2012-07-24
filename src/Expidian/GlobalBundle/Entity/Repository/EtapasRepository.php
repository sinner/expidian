<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Etapas,
    Expidian\GlobalBundle\Entity\Personas,
    Expidian\GlobalBundle\Entity\Perfiles,
    Expidian\GlobalBundle\Entity\Paises,
    Expidian\GlobalBundle\Entity\Estados;

/**
 * EtapasRepository Repositorio de datos de la clase entity GorUSuarios
 *
 * @author Jose Gabriel Gonzalez
 * 
 */
class EtapasRepository extends EntityRepository {
    
    
    public function RegistrarNuevoEtapa(Etapas $etapa, EntityManager $em){
        
        $etapa->setFechaRegistro(new \DateTime());
        $etapa->setEtapaEncrypt($etapa->getEtapa());
        
        try{
            $em->persist($etapa->getPersona());
            $em->persist($etapa);
            $em->flush();
            $result = true;
        }catch(Exception $e){
            $result = false;
        }
        
        return $result;
        
    }
    
    public function EditarEtapa(Etapas $etapa, EntityManager $em){
        
        $etapa->setEtapaEncrypt($etapa->getEtapa());
        
        try{
            $em->persist($etapa->getPersona());
            $em->persist($etapa);
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
    public function queryEtapas($isSearch, $searchField, $searchParam, EntityManager $em){
        
        if($isSearch && $searchField!="" && $searchParam!=""){
            
            switch($searchField){
                case 'id':
                    $searchField = "e.idEtapa";
                    break;
                case 'etapa':
                    $searchField = "e.etapa";
                    break;
                case 'proceso':
                    $searchField = "p.proceso";
                    break;
                case 'inicio':
                    $searchField = "inicio";
                    break; 
            }
            
            $searchParam = strtoupper($searchParam);
            
            if($searchField!='e.idEtapa' && $searchField!="inicio"){
                $filter = $isSearch? " WHERE upper($searchField) LIKE '%$searchParam%' ":"";
            }elseif($searchField=='inicio'){
                $filter = "p.nroConsecutivoProceso = '1' AND e.nroConsecutivoEtapa = '1' ";
            }elseif($searchField!='e.idEtapa'){
                $searchField!="e.idEtapa = '$searchParam'";
            }
            
            $dql = "SELECT e, p FROM ExpidianGlobalBundle:Etapas e JOIN e.proceso p $filter";
            $query = $em->createQuery($dql);
            
        }else{
            
            $dql = "SELECT e, p FROM ExpidianGlobalBundle:Etapas e JOIN e.proceso p ORDER BY e.idEtapa";
            $query = $em->createQuery($dql);
            
        }
        
        //echo $query->getSQL();
        
        return $query;
    }
    
    public function findEtapaInicial(EntityManager $em){
        $etapas = $this->queryEtapas(true,"inicio","",$em)->getResult();
        return $etapas[0];
    }
    
    
}