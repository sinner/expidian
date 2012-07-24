<?php

namespace Expidian\GlobalBundle\Entity;

use Symfony\Component\Security\Core\User\UserInterface;

use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Bridge\Doctrine\Validator\Constraints as DoctrineAssert;

use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;

use Doctrine\ORM\Mapping as ORM;

/**
 * Expidian\GlobalBundle\Entity\Expedientes
 * 
 * @DoctrineAssert\UniqueEntity(fields="idExpediente", message="Este Expediente ya existe en la base de datos.")
 * 
 * @ORM\Table(name="expedientes")
 * @ORM\Entity(repositoryClass="Expidian\GlobalBundle\Entity\Repository\ExpedientesRepository")
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
    private $etapaActual;

    /**
     * @var Organismos
     *
     * @ORM\ManyToOne(targetEntity="Organismos")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_organismo", referencedColumnName="id_organismo")
     * })
     */
    private $organismo;

    /**
     * @var Procesos
     *
     * @ORM\ManyToOne(targetEntity="Procesos")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_proceso_actual", referencedColumnName="id_proceso")
     * })
     */
    private $procesoActual;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_usuario_ini", referencedColumnName="id_usuario")
     * })
     */
    private $usuarioIni;

    /**
     * @var Usuarios
     *
     * @ORM\ManyToOne(targetEntity="Usuarios")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="id_usuario_act", referencedColumnName="id_usuario")
     * })
     */
    private $usuarioAct;



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
     * Set etapaActual
     *
     * @param Expidian\GlobalBundle\Entity\Etapas $etapaActual
     */
    public function setEtapaActual(\Expidian\GlobalBundle\Entity\Etapas $etapaActual)
    {
        $this->etapaActual = $etapaActual;
    }

    /**
     * Get etapaActual
     *
     * @return Expidian\GlobalBundle\Entity\Etapas 
     */
    public function getEtapaActual()
    {
        return $this->etapaActual;
    }

    /**
     * Set organismo
     *
     * @param Expidian\GlobalBundle\Entity\Organismos $organismo
     */
    public function setOrganismo(\Expidian\GlobalBundle\Entity\Organismos $organismo)
    {
        $this->organismo = $organismo;
    }

    /**
     * Get organismo
     *
     * @return Expidian\GlobalBundle\Entity\Organismos 
     */
    public function getOrganismo()
    {
        return $this->organismo;
    }

    /**
     * Set procesoActual
     *
     * @param Expidian\GlobalBundle\Entity\Procesos $procesoActual
     */
    public function setProcesoActual(\Expidian\GlobalBundle\Entity\Procesos $procesoActual)
    {
        $this->procesoActual = $procesoActual;
    }

    /**
     * Get procesoActual
     *
     * @return Expidian\GlobalBundle\Entity\Procesos 
     */
    public function getProcesoActual()
    {
        return $this->procesoActual;
    }

    /**
     * Set usuarioIni
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $usuarioIni
     */
    public function setUsuarioIni(\Expidian\GlobalBundle\Entity\Usuarios $usuarioIni)
    {
        $this->usuarioIni = $usuarioIni;
    }

    /**
     * Get usuarioIni
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getUsuarioIni()
    {
        return $this->usuarioIni;
    }

    /**
     * Set usuarioAct
     *
     * @param Expidian\GlobalBundle\Entity\Usuarios $usuarioAct
     */
    public function setUsuarioAct(\Expidian\GlobalBundle\Entity\Usuarios $usuarioAct)
    {
        $this->usuarioAct = $usuarioAct;
    }

    /**
     * Get usuarioAct
     *
     * @return Expidian\GlobalBundle\Entity\Usuarios 
     */
    public function getUsuarioAct()
    {
        return $this->usuarioAct;
    }
    
    public function __toString()
    {
        return $this->getCodigoActual();
    }
}