<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass="App\Repository\TeamRepository")
 */
class Team
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToMany(targetEntity="App\Entity\Dance")
     * @ORM\JoinColumn(nullable=false)
     * @Assert\Count(min="1", max="10", minMessage="Cette équipe doit contenir au minimum 1 danse", maxMessage="Cette équipe doit contenir au plus 10 danses")
     */
    private $dances;

    /**
     * @ORM\ManyToMany(targetEntity="App\Entity\Dancer", inversedBy="teams")
     * @ORM\JoinColumn(nullable=false)
     * @Assert\Count(min="1", max="20", minMessage="Cette équipe doit contenir au minimum 1 danseur", maxMessage="Cette équipe doit contenir au plus 20 danseurs")
     */
    private $dancers;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\Club", inversedBy="teams")
     * @ORM\JoinColumn(nullable=true)
     */
    private $club;

    /**
     * @ORM\ManyToMany(targetEntity="App\Entity\Competition", mappedBy="teams")
     */
    private $competitions;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\Category", inversedBy="teams")
     * @ORM\JoinColumn(nullable=false)
     */
    private $category;

    /**
     * @ORM\Column(type="boolean")
     */
    private $isPresent;


    public function __construct()
    {
        $this->Dancer = new ArrayCollection();
        $this->category = new ArrayCollection();
        $this->dances = new ArrayCollection();
        $this->dancers = new ArrayCollection();
        $this->competitions = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @return Collection|Dance[]
     */
    public function getDances(): Collection
    {
        return $this->dances;
    }

    public function addDance(Dance $dance): self
    {
        if (!$this->dances->contains($dance)) {
            $this->dances[] = $dance;
        }

        return $this;
    }

    public function removeDance(Dance $dance): self
    {
        if ($this->dances->contains($dance)) {
            $this->dances->removeElement($dance);
        }

        return $this;
    }

    /**
     * @return Collection|Dancer[]
     */
    public function getDancers(): Collection
    {
        return $this->dancers;
    }

    public function addDancer(Dancer $dancer): self
    {
        if (!$this->dancers->contains($dancer)) {
            $this->dancers[] = $dancer;
            $dancer->addTeam($this);
        }

        return $this;
    }

    public function removeDancer(Dancer $dancer): self
    {
        if ($this->dancers->contains($dancer)) {
            $this->dancers->removeElement($dancer);
            $dancer->removeTeam($this);
        }

        return $this;
    }

    public function getClub(): ?Club
    {
        return $this->club;
    }

    public function setClub(?Club $club): self
    {
        $this->club = $club;

        return $this;
    }

    /**
     * @return Collection|Competition[]
     */
    public function getCompetitions(): Collection
    {
        return $this->competitions;
    }

    public function addCompetition(Competition $competition): self
    {
        if (!$this->competitions->contains($competition)) {
            $this->competitions[] = $competition;
            $competition->addTeam($this);
        }

        return $this;
    }

    public function removeCompetition(Competition $competition): self
    {
        if ($this->competitions->contains($competition)) {
            $this->competitions->removeElement($competition);
            $competition->removeTeam($this);
        }

        return $this;
    }

    public function countDancers()
    {
        $i=0;
        foreach ($this->dancers as $nbDancers){
            $i+=1;
        }
        return $i;
    }

    public function getCategory()
    {
        return $this->category;
    }

    public function setCategory(?Category $category): self
    {
        $this->category = $category;

        return $this;
    }

	public function __toString() {
         		return strval($this->getId());
         	}

    public function getIsPresent(): ?bool
    {
        return $this->isPresent;
    }

    public function setIsPresent(bool $isPresent): self
    {
        $this->isPresent = $isPresent;

        return $this;
    }
}