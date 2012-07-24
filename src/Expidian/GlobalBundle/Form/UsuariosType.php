<?php

namespace Expidian\GlobalBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class UsuariosType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('idUsuario', 'hidden')
            ->add('persona', new PersonasType())
            ->add('usuario','number')
            ->add('clave','repeated', array('type' => 'password','invalid_message' => 'Las dos claves deben coincidir', 'first_name'=>'primera', 'second_name'=>'confirmacion'))
            ->add('esActivo', 'choice', array('choices' => array('NO' => 'No', 'SI' => 'Si', ), 'required' => true, ))
            ->add('perfil')
        ;
    }
         
    public function getName()
    {
        return 'usuariotype';
    }
}
