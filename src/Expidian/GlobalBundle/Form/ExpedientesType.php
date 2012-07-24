<?php

namespace Expidian\GlobalBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;
use Expidian\GlobalBundle\Entity\Repository\UsuariosRepository;

class ExpedientesType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('idExpediente', 'hidden')
            ->add('nombre')
            ->add('fechaRegistro', 'date',array(
                        'widget' => 'single_text',
                        'format' => 'dd-MM-yyyy',
                    ))
            ->add('organismo', 'entity', array('class' => 'ExpidianGlobalBundle:Organismos',))
            ->add('usuarioAct', 'entity', array('class' => 'ExpidianGlobalBundle:Usuarios',))
            
        ;
    }
           
    public function getName()
    {
        return 'expedientetype';
    }
}
