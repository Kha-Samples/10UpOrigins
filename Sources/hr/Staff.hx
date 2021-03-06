package hr;

import kha.math.Vector2;
import kha2d.Scene;
import hr.RandomGuy;
import hr.Workplace;

@:access(Main)
class Staff
{
	public static var allguys = new Array<RandomGuy>();
	public static var workplaces = new Array<Workplace>();
	
	public static function hireGuy(slot:Int, newGuy: RandomGuy): Void
	{
		var workplace = workplaces[slot];
		if (!workplace.visible) throw "Das wird niemals passieren.";
		if (workplace.worker != null) throw "Das wird niemals passieren.";

		workplace.worker = newGuy;
		newGuy.workplace = workplace;
		allguys.push(newGuy);

		newGuy.setPosition(Main.npcSpawns[slot]);
		Scene.the.addHero(newGuy);
	}

	public static function update(deltaTime:Float) 
	{
		for (i in 0...allguys.length)
		{
			switch (allguys[i].updateState(deltaTime))
			{
				default:
			}
		}
	}

	public static function calcWages(): Float
	{
		var personMonths: Float = 0;
		for (i in 0...allguys.length)
		{
			if (allguys[i].status != WorkerDead)
			{
				// New hires get only paid for the partial month
				personMonths += Math.min(1, allguys[i].employeeAge) * allguys[i].employeeWage;
			}
		}
		return personMonths;
	}

	public static function calcWorkplaceCosts(): Float
	{
		var costs: Float = 0;
		for (i in 0...workplaces.length)
		{
			if (workplaces[i].visible) 
			{
				costs += FactoryState.workplaceCostsPerYear;
			}
		}
		return costs;
	}
}
