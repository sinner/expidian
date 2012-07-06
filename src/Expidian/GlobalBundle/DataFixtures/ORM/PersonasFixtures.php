<?php

namespace Expidian\GlobalBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Paises;

/**
 * Description of PersonasFixtures
 *
 * @author jgonza67
 */
class PersonasFixtures extends AbstractFixture implements OrderedFixtureInterface {
    
    public function load(ObjectManager $manager) {
        
        $nombres = array('Jose', 'Maria', 'Leonel', 'Gabriel', 'Ignacio', 'Daniel', 'Daniel', 'Ricardo', 'Rosbely', 'Andreina');
        $apellidos = array('Espinoza', 'Hernandez', 'Perez', 'Pirela', 'Pulido','Vargas', 'Lozada', 'Mata', 'Silva', 'Bolivar');
        
        $pais_obj = $manager->getRepository("ExpidianGlobalBundle:Paises")->findOneByPais("Venezuela");
        
        for ($i=0;$i<=35;$i++){
            $personas[$i] = new Personas();
            $persona_obj = $personas[$i];
            $aleatorio = mt_rand(0,9);
            $persona_obj->setNombre($nombres[$aleatorio]);
            $persona_obj->setApellido($apellidos[$aleatorio]);
            $persona_obj->setCedulaDeIdentidad('123456'.$i);
            $persona_obj->setNacionalidad('V');
            $persona_obj->setPais($pais_obj);
            $persona_obj->setEmail($nombres[$aleatorio].$i.'@hotmail.com');
            $persona_obj->setTelefono1('2125555555');
            //var_dump($persona_obj);
            $manager->persist($persona_obj);
            $this->addReference('persona'.$i.'ref', $persona_obj);
        }
        
        $manager->flush();
        
    }

    public function getOrder() {
        return 1;
    }
    
}

?>
