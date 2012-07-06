<?php

namespace Expidian\GlobalBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class PersonasType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('idPersona','hidden')
            ->add('nombre')
            ->add('apellido')
            ->add('nacionalidad', 'choice', array('choices' => array('V' => 'Venezolano(a)', 'E' => 'Extrangero(a)', ), 'required' => false, 'empty_value'=>' - - - ', 'empty_data'=>null))
            ->add('cedulaDeIdentidad','number')
            ->add('telefono1','number',array('required'=>false))
            ->add('telefono2','number',array('required'=>false))
            ->add('email','email',array('required'=>false))
            ->add('pais', 'entity', array('class' => 'ExpidianGlobalBundle:Paises',))
            
        ;
    }
           
    public function getName()
    {
        return 'personatype';
    }
}
