<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Competition;
use App\Entity\Dance;
use App\Entity\Row;
use App\Entity\Team;
use App\Repository\CategoryRepository;
use App\Repository\CompetitionRepository;
use App\Repository\DanceRepository;
use App\Repository\RowRepository;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;

class PlanningController extends AbstractController
{
    /**
     * @Route("/planning", name="Planning.index")
     */
    public function index(SessionInterface $session, CompetitionRepository $competitionRepository) {
	    $compet = $session->get('competSelected');
	    $compet=$this->getDoctrine()->getRepository(Competition::class)->find($compet);

	    $rows = $competitionRepository -> findAll();
        $test=$this->getDoctrine()->getRepository(Row::class)->findBy(["competition"=>$compet]);
        foreach ($test as $t){
            $teams=$t->getTeams();
        }
        //die();
        return $this->render('planning/index.html.twig', [

        ]);
    }

    /**
     * @Route("/planning/get", name="Planning.get", methods={"GET"})
     */
    public function testAjax(RowRepository $rowRepository){

        $row= $rowRepository->findRowsOrderedByPosition();

        return $this->json(['row'=>$row],Response::HTTP_OK, [], [
            ObjectNormalizer::GROUPS => ['planning'],
        ]);
    }

    /**
     * @Route("/planning/validation", name="Planning.validation", methods={"POST"})
     */
	public function validationRows(Request $request,
                                 SessionInterface $session,
	                             ObjectManager $manager,
	                             CategoryRepository $categoryRepository,
	                             DanceRepository $danceRepository,
	                             RowRepository $rowRepository) {
//		$rows = $request->getContent();
        $compet=$this->getDoctrine()->getRepository(Competition::class)->find($session->get('competSelected'));
		$parametersAsArray = array();
		if ($content = $request->getContent()){
			$parametersAsArray = json_decode($content, true);
		}
		//vide la table Row
//		$rows = $rowRepository->findAll();
//		foreach ($rows as $line){
//			$manager->remove($line);
//		}
//		$manager->flush();

		foreach ($parametersAsArray as $param){
			$compteurPosition = 1;
			foreach ($param as $rows){
				$idRow = $rows['id'];
//				$category= $categoryRepository->findOneBy(['nameCategory'=>$rows['category']['nameCategory']]);
//				$dance = $danceRepository->findOneBy(['nameDance'=>$rows['dance']['nameDance']]);
				if ($rows['numTour'] == "1"){
					$teams=$this->getDoctrine()->getRepository(Team::class)->getTeamsByCat($rows['dance']['nameDance'], $rows['category']['nameCategory'], $rows['formation'],$session->get('competSelected'));
				}else{
					$teams=[];
					foreach ($rows['teams'] as $team){
						array_push($teams, $team['id']);
					}
				}
				$row = $rowRepository->find($idRow);
				$row->setPosition($compteurPosition)
					->setPiste($rows['piste'])
					->setNumTour($rows['numTour'])
					->setNbJudge($rows['nbJudge'])
					->setPassageSimul($rows['passageSimul'])
				;
//				$row = new Row();
//                $row->setDance($dance)
//                    ->setCompetition($compet)
//                    ->setCategory($category)
//                    ->setFormation($rows['formation'])
//                    ->setNumTour($rows['numTour'])
//                    ->setPiste($rows['piste'])
//                    ->setIsDone($rows['isDone'])
//                    ->setNbJudge($rows['nbJudge'])
//	                ->setPosition($compteurPosition)
//                    ->setPassageSimul($rows['passageSimul'])
//                ;

//                foreach ($teams as $team){
//                    $row->addTeam($this->getDoctrine()->getRepository(Team::class)->find($team));
//                }
                $manager->persist($row);
                $compteurPosition += 1;
			}
		}
		$manager->flush();
		return new Response('test');
    }

    /**
     * @Route("/planning/actuel", name="Planning.actualPlanning")
     */
	public function actualPlanning(RowRepository $rowRepository) {
		return $this->render('planning/planningActuel.html.twig',[
			'rows'=>$rowRepository->findToDoRow(),
		]);
    }

	/**
	 * @Route("/planning/previous", name="Planning.previousPlanning")
	 */
	public function previousRound(RowRepository $rowRepository) {
		return $this->render('planning/planningPrevious.html.twig',[
			'rows'=>$rowRepository->findByIsDone(),
		]);
	}
}
