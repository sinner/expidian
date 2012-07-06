<?php

namespace Expidian\GlobalBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;

/**
 * Description of UsuariosFixtures
 *
 * @author jgonza67
 */
class UsuariosFixtures extends AbstractFixture implements OrderedFixtureInterface {
    
    public function load(ObjectManager $manager) {
        
        $perfil1 = $manager->getRepository("ExpidianGlobalBundle:Perfiles")->findOneByIdPerfil(1);
        $perfil2 = $manager->getRepository("ExpidianGlobalBundle:Perfiles")->findOneByIdPerfil(2);
        
        var_dump($perfil1);
        var_dump($perfil2);
        
        $perfiles = array($perfil1,$perfil2);
        
        $activos = array('SI','NO');
        
        for($i=0;$i<=35;$i++){
            
            $aleatorio = mt_rand(0,1);
            $persona_obj = $manager->merge($this->getReference('persona'.$i.'ref'));
            $usuario = new Usuarios();
            $usuario->setUsuario($persona_obj->getCedulaDeIdentidad());
            $usuario->setUsuarioEncrypt($persona_obj->getCedulaDeIdentidad());
            $usuario->setClave('123456');
            $usuario->setPersona($persona_obj);
            $usuario->setPerfil($perfiles[$aleatorio]);
            $usuario->setFechaRegistro(new \DateTime());
            $usuario->setEsActivo($activos[$aleatorio]);
            $manager->persist($usuario);
            
        }
        
        $manager->flush();
        
    }
    
    public function getOrder()
    {
        return 2;
    }
}

?>
