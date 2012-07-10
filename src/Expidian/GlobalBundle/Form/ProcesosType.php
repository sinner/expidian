<?php

namespace Expidian\GlobalBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class ProcesosType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('idProceso','hidden')
            ->add('proceso','text')
            ->add('procesoAbrev','text')
            ->add('nroConsecutivoProceso', 'number')
        ;
    }
           
    public function getName()
    {
        return 'procesotype';
    }
}
