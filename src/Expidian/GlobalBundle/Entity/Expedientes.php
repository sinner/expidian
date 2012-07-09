<?php

namespace Expidian\GlobalBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Expedientes
 *
 * @ORM\Table(name="expedientes")
 * @ORM\Entity
 */
class Expedientes
{
    /**
     * @var integer $idExpediente
     *
     * @ORM\Column(name="id_expediente", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="expedientes_id_expediente_seq", allocationSize="1", initialValue="1")
     */
    private $idExpediente;

    /**
     * @var string $nombre
     *
     * @ORM\Column(name="nombre", type="string", length=20, nullable=true)
     */
    private $nombre;

    /**
     * @var string $codigoActual
     *
     * @ORM\Column(name="codigo_actual", type="string", length=20, nullable=true)
     */
    private $codigoActual;

    /**
     * @var string $sesssionId
     *
     * @ORM\Column(name="sesssion_id", type="string", length=255, nullable=true)
     */
    private $sesssionId;

    /**
     * @var string $confirmInicial
     *
     * @ORM\Column(name="confirm_inicial", type="string", length=10, nullable=true)
     */
    private $confirmInicial;

    /**
     * @var date $fechaRegistro
     *
     * @ORM\Column(name="fecha_registro", type="date", nullable=false)
     */
    private $fechaRegistro;

    /**
     * @var Etapas
     *
     * @ORM\ManyToOne(targetEntity="Etapas")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_etapa_actual", referencedColumnName="id_etapa")
     * })
     */
    private $idEtapaActual;

    /**
     * @var Organismos
     *
     * @ORM\ManyToOne(targetEntity="Organismos")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_organismo", referencedColumnName="id_organismo")
     * })
     */
    private $idOrganismo;

    /**
     * @var Procesos
     *
     * @ORM\ManyToOne(targetEntity="Procesos")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_proceso_actual", referencedColumnName="id_proceso")
     * })
     */
    private $idProcesoActual;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_usuario_ini", referencedColumnName="id_usuario")
     * })
     */
    private $idUsuarioIni;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_usuario_act", referencedColumnName="id_usuario")
     * })
     */
    private $idUsuarioAct;



    /**
     * Get idExpediente
     *
     * @return integer 
     */
    public function getIdExpediente()
    {
        return $this->idExpediente;
    }

    /**
     * Set nombre
     *
     * @param string $nombre
     */
    public function setNombre($nombre)
    {
        $this->nombre = $nombre;
    }

    /**
     * Get nombre
     *
     * @return string 
     */
    public function getNombre()
    {
        return $this->nombre;
    }

    /**
     * Set codigoActual
     *
     * @param string $codigoActual
     */
    public function setCodigoActual($codigoActual)
    {
        $this->codigoActual = $codigoActual;
    }

    /**
     * Get codigoActual
     *
     * @return string 
     */
    public function getCodigoActual()
    {
        return $this->codigoActual;
    }

    /**
     * Set sesssionId
     *
     * @param string $sesssionId
     */
    public function setSesssionId($sesssionId)
    {
        $this->sesssionId = $sesssionId;
    }

    /**
     * Get sesssionId
     *
     * @return string 
     */
    public function getSesssionId()
    {
        return $this->sesssionId;
    }

    /**
     * Set confirmInicial
     *
     * @param string $confirmInicial
     */
    public function setConfirmInicial($confirmInicial)
    {
        $this->confirmInicial = $confirmInicial;
    }

    /**
     * Get confirmInicial
     *
     * @return string 
     */
    public function getConfirmInicial()
    {
        return $this->confirmInicial;
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
     * Set idEtapaActual
     *
     * @param Expidian\GlobalBundle\Entity\Etapas $idEtapaActual
     */
    public function setIdEtapaActual(\Expidian\GlobalBundle\Entity\Etapas $idEtapaActual)
    {
        $this->idEtapaActual = $idEtapaActual;
    }

    /**
     * Get idEtapaActual
     *
     * @return Expidian\GlobalBundle\Entity\Etapas 
     */
    public function getIdEtapaActual()
    {
        return $this->idEtapaActual;
    }

    /**
     * Set idOrganismo
     *
     * @param Expidian\GlobalBundle\Entity\Organismos $idOrganismo
     */
    public function setIdOrganismo(\Expidian\GlobalBundle\Entity\Organismos $idOrganismo)
    {
        $this->idOrganismo = $idOrganismo;
    }

    /**
     * Get idOrganismo
     *
     * @return Expidian\GlobalBundle\Entity\Organismos 
     */
    public function getIdOrganismo()
    {
        return $this->idOrganismo;
    }

    /**
     * Set idProcesoActual
     *
     * @param Expidian\GlobalBundle\Entity\Procesos $idProcesoActual
     */
    public function setIdProcesoActual(\Expidian\GlobalBundle\Entity\Procesos $idProcesoActual)
    {
        $this->idProcesoActual = $idProcesoActual;
    }

    /**
     * Get idProcesoActual
     *
     * @return Expidian\GlobalBundle\Entity\Procesos 
     */
    public function getIdProcesoActual()
    {
        return $this->idProcesoActual;
    }

    /**
     * Set idUsuarioIni
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $idUsuarioIni
     */
    public function setIdUsuarioIni(\Expidian\GlobalBundle\Entity\Usuarios $idUsuarioIni)
    {
        $this->idUsuarioIni = $idUsuarioIni;
    }

    /**
     * Get idUsuarioIni
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getIdUsuarioIni()
    {
        return $this->idUsuarioIni;
    }

    /**
     * Set idUsuarioAct
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $idUsuarioAct
     */
    public function setIdUsuarioAct(\Expidian\GlobalBundle\Entity\Usuarios $idUsuarioAct)
    {
        $this->idUsuarioAct = $idUsuarioAct;
    }

    /**
     * Get idUsuarioAct
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getIdUsuarioAct()
    {
        return $this->idUsuarioAct;
    }
}