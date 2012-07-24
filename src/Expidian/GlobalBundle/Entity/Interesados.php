<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Interesados
 *
 * @ORM\Table(name="interesados")
 * @ORM\Entity
 */
class Interesados
{
    /**
     * @var integer $idInteresado
     *
     * @ORM\Column(name="id_interesado", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="interesados_id_interesado_seq", allocationSize="1", initialValue="1")
     */
    private $idInteresado;

    /**
     * @var Personas
     *
     * @ORM\ManyToOne(targetEntity="Personas")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="cedula_de_identidad", referencedColumnName="cedula_de_identidad")
     * })
     */
    private $cedulaDeentidad;

    /**
     * @var Expedientes
     *
     * @ORM\ManyToOne(targetEntity="Expedientes")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_expediente", referencedColumnName="id_expediente")
     * })
     */
    private $idExpediente;



    /**
     * Get idInteresado
     *
     * @return integer 
     */
    public function getIdInteresado()
    {
        return $this->idInteresado;
    }

    /**
     * Set cedulaDeentidad
     *
     * @param Expidian\GlobalBundle\Entity\Personas $cedulaDeentidad
     */
    public function setCedulaDeentidad(\Expidian\GlobalBundle\Entity\Personas $cedulaDeentidad)
    {
        $this->cedulaDeentidad = $cedulaDeentidad;
    }

    /**
     * Get cedulaDeentidad
     *
     * @return Expidian\GlobalBundle\Entity\Personas 
     */
    public function getCedulaDeentidad()
    {
        return $this->cedulaDeentidad;
    }

    /**
     * Set idExpediente
     *
     * @param Expidian\GlobalBundle\Entity\Expedientes $idExpediente
     */
    public function setIdExpediente(\Expidian\GlobalBundle\Entity\Expedientes $idExpediente)
    {
        $this->idExpediente = $idExpediente;
    }

    /**
     * Get idExpediente
     *
     * @return Expidian\GlobalBundle\Entity\Expedientes 
     */
    public function getIdExpediente()
    {
        return $this->idExpediente;
    }
}