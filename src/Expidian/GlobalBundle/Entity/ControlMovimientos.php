<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\ControlMovimientos
 *
 * @ORM\Table(name="control_movimientos")
 * @ORM\Entity
 */
class ControlMovimientos
{
    /**
     * @var integer $idControlMovimientos
     *
     * @ORM\Column(name="id_control_movimientos", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="control_movimientos_id_control_movimientos_seq", allocationSize="1", initialValue="1")
     */
    private $idControlMovimientos;

    /**
     * @var string $codExpediente
     *
     * @ORM\Column(name="cod_expediente", type="string", length=11, nullable=false)
     */
    private $codExpediente;

    /**
     * @var date $fechaMovimiento
     *
     * @ORM\Column(name="fecha_movimiento", type="date", nullable=false)
     */
    private $fechaMovimiento;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_abogado_asign", referencedColumnName="id_usuario")
     * })
     */
    private $idAbogadoAsign;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_abogado_coord", referencedColumnName="id_usuario")
     * })
     */
    private $idAbogadoCoord;

    /**
     * @var Etapas
     *
     * @ORM\ManyToOne(targetEntity="Etapas")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_etapa", referencedColumnName="id_etapa")
     * })
     */
    private $idEtapa;

    /**
     * @var Expedientes
     *
     * @ORM\ManyToOne(targetEntity="Expedientes")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_expidiente", referencedColumnName="id_expediente")
     * })
     */
    private $idExpidiente;

    /**
     * @var Procesos
     *
     * @ORM\ManyToOne(targetEntity="Procesos")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_proceso", referencedColumnName="id_proceso")
     * })
     */
    private $idProceso;



    /**
     * Get idControlMovimientos
     *
     * @return integer 
     */
    public function getIdControlMovimientos()
    {
        return $this->idControlMovimientos;
    }

    /**
     * Set codExpediente
     *
     * @param string $codExpediente
     */
    public function setCodExpediente($codExpediente)
    {
        $this->codExpediente = $codExpediente;
    }

    /**
     * Get codExpediente
     *
     * @return string 
     */
    public function getCodExpediente()
    {
        return $this->codExpediente;
    }

    /**
     * Set fechaMovimiento
     *
     * @param date $fechaMovimiento
     */
    public function setFechaMovimiento($fechaMovimiento)
    {
        $this->fechaMovimiento = $fechaMovimiento;
    }

    /**
     * Get fechaMovimiento
     *
     * @return date 
     */
    public function getFechaMovimiento()
    {
        return $this->fechaMovimiento;
    }

    /**
     * Set idAbogadoAsign
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $idAbogadoAsign
     */
    public function setIdAbogadoAsign(\Expidian\GlobalBundle\Entity\Usuarios $idAbogadoAsign)
    {
        $this->idAbogadoAsign = $idAbogadoAsign;
    }

    /**
     * Get idAbogadoAsign
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getIdAbogadoAsign()
    {
        return $this->idAbogadoAsign;
    }

    /**
     * Set idAbogadoCoord
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $idAbogadoCoord
     */
    public function setIdAbogadoCoord(\Expidian\GlobalBundle\Entity\Usuarios $idAbogadoCoord)
    {
        $this->idAbogadoCoord = $idAbogadoCoord;
    }

    /**
     * Get idAbogadoCoord
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getIdAbogadoCoord()
    {
        return $this->idAbogadoCoord;
    }

    /**
     * Set idEtapa
     *
     * @param Expidian\GlobalBundle\Entity\Etapas $idEtapa
     */
    public function setIdEtapa(\Expidian\GlobalBundle\Entity\Etapas $idEtapa)
    {
        $this->idEtapa = $idEtapa;
    }

    /**
     * Get idEtapa
     *
     * @return Expidian\GlobalBundle\Entity\Etapas 
     */
    public function getIdEtapa()
    {
        return $this->idEtapa;
    }

    /**
     * Set idExpidiente
     *
     * @param Expidian\GlobalBundle\Entity\Expedientes $idExpidiente
     */
    public function setIdExpidiente(\Expidian\GlobalBundle\Entity\Expedientes $idExpidiente)
    {
        $this->idExpidiente = $idExpidiente;
    }

    /**
     * Get idExpidiente
     *
     * @return Expidian\GlobalBundle\Entity\Expedientes 
     */
    public function getIdExpidiente()
    {
        return $this->idExpidiente;
    }

    /**
     * Set idProceso
     *
     * @param Expidian\GlobalBundle\Entity\Procesos $idProceso
     */
    public function setIdProceso(\Expidian\GlobalBundle\Entity\Procesos $idProceso)
    {
        $this->idProceso = $idProceso;
    }

    /**
     * Get idProceso
     *
     * @return Expidian\GlobalBundle\Entity\Procesos 
     */
    public function getIdProceso()
    {
        return $this->idProceso;
    }
}