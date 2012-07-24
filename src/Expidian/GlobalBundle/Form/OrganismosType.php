<?php

namespace Expidian\GlobalBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilder;

class OrganismosType extends AbstractType
{
    public function buildForm(FormBuilder $builder, array $options)
    {
        $builder
            ->add('idOrganismo','hidden')
            ->add('nombreOrganismo')
            ->add('rif')
            ->add('sector')
        ;
    }
           
    public function getName()
    {
        return 'organismotype';
    }
}
