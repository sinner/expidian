<?php

namespace Expidian\GlobalBundle\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\QueryBuilder;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\NativeQuery;

use Expidian\GlobalBundle\Entity\Usuarios,
    Expidian\GlobalBundle\Entity\Personas,
    Expidian\GlobalBundle\Entity\Perfiles,
    Expidian\GlobalBundle\Entity\Paises,
    Expidian\GlobalBundle\Entity\Estados;

/**
 * UsuariosRepository Repositorio de datos de la clase entity GorUSuarios
 *
 * @author José Gabriel Gonzalez perez
 * 
 */
class UsuariosRepository extends EntityRepository {
    
    
    public function RegistrarNuevoUsuario(Usuarios $usuario, EntityManager $em){
        
        $usuario->setFechaRegistro(new \DateTime());
        $usuario->setUsuarioEncrypt($usuario->getUsuario());
        
        try{
            $em->persist($usuario->getPersona());
            $em->persist($usuario);
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
    public function queryUsuarios($isSearch, $searchField, $searchParam, EntityManager $em){
        
        if($isSearch && $searchField!="" && $searchParam!=""){
            
            switch($searchField){
                case 'nombre':
                    $searchField = "CONCAT(h.nombre,h.apellido)";
                case 'usuario':
                    $searchField = "u.usuario";
                case 'perfil':
                    $searchField = "p.perfil";
            }

            $filter = $isSearch? " WHERE UPPER($searchField) LIKE UPPER('%:param%') ":"";
            
            $dql = "SELECT u, p, h, n FROM ExpidianGlobalBundle:Usuarios u JOIN u.perfil p JOIN u.persona h JOIN h.pais n $filter";
            $query = $em->createQuery($dql)->setParameter('param', $searchParam);
            
        }else{
            
            $dql = "SELECT u, p, h, n FROM ExpidianGlobalBundle:Usuarios u JOIN u.perfil p JOIN u.persona h JOIN h.pais n";
            $query = $em->createQuery($dql);
            
        }
        
        //echo $query->getSQL();
        
        return $query;
    }


    /**
     * @param String $usuario Usuario de Red
     * @param String $clave Clave del Susuario, Generalmente codificada mediante el metodo md5
     * @return Object 
     */
    public function autenticarUsuario($usuario, $clave){
        
        $result = null;
        
        if(func_num_args()==2){
            
            $usuario_prm = hash("sha512",$usuario);
            $clave_prm = hash("sha512",$clave);
            
            $em = $this->getEntityManager();
            
            $rsm = new ResultSetMapping();
            
            $rsm->addEntityResult('Expidian\GlobalBundle\Entity\Usuarios', 'a');
            $rsm->addFieldResult('a','id_usuario','idUsuario');
            $rsm->addFieldResult('a','usuario','usuario');
            $rsm->addFieldResult('a','usuario_encrypt','usuarioEncrypt');
            $rsm->addFieldResult('a','fecha_registro','fechaRegistro');
            $rsm->addFieldResult('a','clave','clave');
            $rsm->addFieldResult('a','fecha_ultimo_ingreso','fechaUltimoIngreso');
            $rsm->addFieldResult('a','es_activo','esActivo');
                        
            $rsm->addJoinedEntityResult('Expidian\GlobalBundle\Entity\Personas', 'b', 'a', 'persona');
            $rsm->addFieldResult('b','id_persona','idPersona');
            $rsm->addFieldResult('b','nombre','nombre');
            $rsm->addFieldResult('b','apellido','apellido');
            $rsm->addFieldResult('b','nacionalidad','nacionalidad');
            $rsm->addFieldResult('b','cedula_de_identidad','cedulaDeIdentidad');
            $rsm->addFieldResult('b','telefono1','telefono1');
            $rsm->addFieldResult('b','telefono2','telefono2');
            $rsm->addFieldResult('b','email','email');
            
            $rsm->addJoinedEntityResult('Expidian\GlobalBundle\Entity\Perfiles', 'c', 'a', 'perfil');
            $rsm->addFieldResult('c','id_perfil','idPerfil');
            $rsm->addFieldResult('c','perfil','perfil');
            $rsm->addFieldResult('c','descripcion_perfil','descripcionPerfil');
            
            $rsm->addJoinedEntityResult('Expidian\GlobalBundle\Entity\Paises', 'd', 'b', 'pais');
            $rsm->addFieldResult('d','id_pais','idPais');
            $rsm->addFieldResult('d','pais','pais');
                                 
            $sql = "SELECT 
                        a.id_usuario, 
                        a.usuario, 
                        a.usuario_encrypt, 
                        to_char(a.fecha_registro, 'YYYY-MM-DD') AS fecha_registro, 
                        a.clave, 
                        to_char(a.fecha_ultimo_ingreso, 'YYYY-MM-DD') AS fecha_ultimo_ingreso, 
                        a.es_activo, 
                        b.id_persona,
                        b.nombre, 
                        b.apellido, 
                        b.nacionalidad, 
                        b.cedula_de_identidad, 
                        b.telefono1, 
                        b.telefono2, 
                        b.email, 
                        c.id_perfil, 
                        c.perfil, 
                        c.descripcion_perfil,
                        d.id_pais, 
                        d.pais
                    FROM 
                        usuarios a 
                    INNER JOIN 
                        personas b 
                    INNER JOIN 
                        paises d ON d.id_pais = b.id_pais 
                        ON b.id_persona = a.id_persona  
                    INNER JOIN 
                        perfiles c ON c.id_perfil = a.id_perfil
                    WHERE a.usuario_encrypt = :usuario_prm AND a.clave = :clave_prm";
            
            $query = $em->createNativeQuery($sql, $rsm);
            $query->setParameters(array(
                            'usuario_prm' => $usuario_prm,
                            'clave_prm' => $clave_prm
                          ));
                       
            //echo $query->getSQL();
            //echo $query->getParameters();
            
            $result = $query->getResult();
            
            if (count($result)>0) {
               
               $usuario_obj = $result[0];
               $result = $usuario_obj;
                              
            }
            
            //var_dump($usuario_obj);
            
        }
        
        return $result;
    }
    
}