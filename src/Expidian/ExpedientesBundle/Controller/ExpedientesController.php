<?php

namespace Expidian\ExpedientesBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;


class ExpedientesController extends Controller
{
    
    public function indexAction($name)
    {
        return $this->render('ExpidianExpedientesBundle:Default:index.html.twig', array('name' => $name));
    }
}
