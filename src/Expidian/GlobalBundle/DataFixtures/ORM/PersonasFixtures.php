<?php

namespace Expidian\GlobalBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Paises;

/**
 * Description of UsuariosFixtures
 *
 * @author jgonza67
 */
class PersonasFixtures extends AbstractFixture implements OrderedFixtureInterface {
    
    public function load(ObjectManager $manager) {
        
        $pais_obj = $manager->find("ExpidianGlobalBundle:Paises",233);
        
        echo "(---";
        print_r($pais_obj);
        echo "---)";
        
        $nombres = array('José', 'María', 'Leonel', 'Gabriel', 'Ignacio', 'Daniel', 'Daniel', 'Ricardo', 'Rosbely', 'Andreina');
        $apellidos = array('Espinoza', 'Hernández', 'Perez', 'Pirela', 'Pulido','Vargas', 'Lozada', 'Mata', 'Silva', 'Bolívar');
        
        for ($i=0;$i<=35;$i++){
            $personas[$i] = new Personas();
            $persona_obj = $personas[$i];
            $aleatorio = mt_rand(0,9);
            $persona_obj->setNombre($nombres[$aleatorio]);
            $persona_obj->setApellido($apellidos[mt_rand(0,9)]);
            $persona_obj->setCedulaDeIdentidad('123456'.$i);
            $persona_obj->setNacionalidad('V');
            $persona_obj->setPais($pais_obj);
            $persona_obj->setEmail($nombres[$aleatorio].$i.'@hotmail.com');
            $persona_obj->setTelefono1('2125555555');
            $manager->persist($persona_obj);
            $this->addReference('persona-'.$i, $persona_obj);
        }
        
        $manager->flush();
        
    }

    public function getOrder() {
        return 1;
    }
    
}

?>
