<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Bitacoras
 *
 * @ORM\Table(name="bitacoras")
 * @ORM\Entity
 */
class Bitacoras
{
    /**
     * @var integer $idBitacora
     *
     * @ORM\Column(name="id_bitacora", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="bitacoras_id_bitacora_seq", allocationSize="1", initialValue="1")
     */
    private $idBitacora;

    /**
     * @var text $bitacora
     *
     * @ORM\Column(name="bitacora", type="text", nullable=false)
     */
    private $bitacora;

    /**
     * @var date $fechaRegistro
     *
     * @ORM\Column(name="fecha_registro", type="date", nullable=false)
     */
    private $fechaRegistro;

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
     * Get idBitacora
     *
     * @return integer 
     */
    public function getIdBitacora()
    {
        return $this->idBitacora;
    }

    /**
     * Set bitacora
     *
     * @param text $bitacora
     */
    public function setBitacora($bitacora)
    {
        $this->bitacora = $bitacora;
    }

    /**
     * Get bitacora
     *
     * @return text 
     */
    public function getBitacora()
    {
        return $this->bitacora;
    }

    /**
     * Set fechaRegistro
     *
     * @param date $fechaRegistro
     */
    public function setFechaRegistro($fechaRegistro)
    {
        $this->fechaRegistro = $fechaRegistro;
    }

    /**
     * Get fechaRegistro
     *
     * @return date 
     */
    public function getFechaRegistro()
    {
        return $this->fechaRegistro;
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
}