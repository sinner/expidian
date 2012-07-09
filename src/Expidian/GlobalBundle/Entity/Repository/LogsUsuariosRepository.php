<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Expidian\GlobalBundle\Entity\LogsUsuarios;
use Expidian\GlobalBundle\Entity\Usuarios;

/**
 * LogsUsuariosRepository Repositorio de datos de la clase entity LogsUsuarios
 *
 * @author Jose Gabriel Gonzalez
 */
class LogsUsuariosRepository extends EntityRepository {
    
    
    public function registrarAccion(LogsUsuarios $log_obj, Usuarios $usuario, $logUsuario, $estatusFinal){
        
        //Creo mi objeto de Logs colocando valores a cada una de las propiedades
        $log_obj->setUsuario($usuario);
        $log_obj->setEstatusFinal($estatusFinal);
        $log_obj->setLogUsuario($logUsuario);
        $log_obj->setFechaLog(new \DateTime());
                
        //Obtengo el manejador de entidades que se encargará de efectuar la persistencia del objeto Logs en la base de datos
        $em = $this->getEntityManager();
        //Le digo a el manejador de entidades que se encargue de este objeto
        $em->persist($log_obj);
        //comienzo una transaccion
        $em->flush();
        
        return true;
    }
    
}

?>