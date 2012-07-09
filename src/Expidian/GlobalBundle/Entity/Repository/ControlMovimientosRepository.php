<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Etapas,
    Expidian\GlobalBundle\Entity\Procesos,
    Expidian\GlobalBundle\Entity\Expedientes,
    Expidian\GlobalBundle\Entity\Usuarios,
    Expidian\GlobalBundle\Entity\ControlMovimientos;

/**
 * EtapasRepository Repositorio de datos de la clase entity 
 *
 * @author Jose Gabriel Gonzalez
 * 
 */
class ControlMovimientosRepository extends EntityRepository {
   
    
    /**
     *
     * @param EntityManager $em
     * @param Etapas $etapa
     * @return string 
     */
    public function getCodigoExp(EntityManager $em, Etapas $etapa){
        
        $fecha_inicio = date('Y')."-01-01";
        $fecha_final = date('Y')."-12-31";
        
        $dql = "SELECT COUNT(m.idControlMovimientos) FROM ExpidianGlobalBundle:ControlMovimientos m WHERE m.idEtapa = '".$etapa->getIdEtapa()."' AND m.fechaMovimiento BETWEEN '$fecha_inicio' AND '$fecha_final'";
        $query = $em->createQuery($dql);
        $num = ($query->getResult(Query::HYDRATE_SINGLE_SCALAR)*1)+1;
        
        for($i=0;$i<=8;$i++){
            $num = '0'.$num;
        }
        
        $codExp = $etapa->getProceso()->getProcesoAbrev()."-".$num."-".substr(date('Y'), 2);
        
        return $codExp;
    }
    
}