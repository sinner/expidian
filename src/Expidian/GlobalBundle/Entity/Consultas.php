<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Consultas
 *
 * @ORM\Table(name="consultas")
 * @ORM\Entity
 */
class Consultas
{
    /**
     * @var integer $idConsulta
     *
     * @ORM\Column(name="id_consulta", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="consultas_id_consulta_seq", allocationSize="1", initialValue="1")
     */
    private $idConsulta;

    /**
     * @var string $cedulaDeIdentidad
     *
     * @ORM\Column(name="cedula_de_identidad", type="string", length=15, nullable=false)
     */
    private $cedulaDeIdentidad;

    /**
     * @var date $fechaConsulta
     *
     * @ORM\Column(name="fecha_consulta", type="date", nullable=false)
     */
    private $fechaConsulta;

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
     * Get idConsulta
     *
     * @return integer 
     */
    public function getIdConsulta()
    {
        return $this->idConsulta;
    }

    /**
     * Set cedulaDeIdentidad
     *
     * @param string $cedulaDeIdentidad
     */
    public function setCedulaDeIdentidad($cedulaDeIdentidad)
    {
        $this->cedulaDeIdentidad = $cedulaDeIdentidad;
    }

    /**
     * Get cedulaDeIdentidad
     *
     * @return string 
     */
    public function getCedulaDeIdentidad()
    {
        return $this->cedulaDeIdentidad;
    }

    /**
     * Set fechaConsulta
     *
     * @param date $fechaConsulta
     */
    public function setFechaConsulta($fechaConsulta)
    {
        $this->fechaConsulta = $fechaConsulta;
    }

    /**
     * Get fechaConsulta
     *
     * @return date 
     */
    public function getFechaConsulta()
    {
        return $this->fechaConsulta;
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