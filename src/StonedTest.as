//
// async library
// Copyright (C) 2013 Lucas Teixeira (Disturbed Coder)
// Project page: https://github.com/loteixeira/async
//
// This software is distribuited under the terms of the Do What the Fuck You Want to Public License
// http://www.wtfpl.net/txt/copying/
//
package
{
	import br.dcoder.console.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	import stoned.*;

	[SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class StonedTest extends Sprite
	{
		public function StonedTest()
		{
			Console.create(this);
			Console.instance.draggable = false;
			Console.instance.resizable = false;
			cpln("stonedflash library version " + stonedVersion());
			cpln("starting test...");
			cpln("");

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.addEventListener(Event.RESIZE, resize);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			resize(null);
			start();
		}

		private function resize(e:Event):void
		{
			Console.instance.area = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight)
		}

		private function start():void
		{
			var primeTask:StonedFor = new StonedFor(
					// run
					function(p:Object):Boolean
					{
						var isPrime:Boolean = true;

						for (var i:uint = 2; i < p.i; i++)
						{
							if (p.i % i == 0)
							{
								isPrime = false;
								break;
							}
						}

						if (isPrime)
						{
							p.primeCount++;
							cpln("Prime found! " + p.i + " (" + p.primeCount + ")");

							if (p.primeCount == p.targetPrime)
								p.value = p.i;
						}

						return true;
					},

					// condition
					function (p:Object):Boolean
					{
						return p.primeCount < p.targetPrime;
					},

					// increment
					function (p:Object):void
					{
						p.i++;
					},

					// enter
					function (p:Object):void
					{
						cpln("#######");
						cpln("Tring to find the " + p.targetPrime + "th prime number");
					},

					// exit
					function (p:Object):void
					{
						cpln("The " + p.targetPrime + "th prime number is " + p.value);
					},

					// param
					{i: 1, primeCount: 0, targetPrime: 10, value: -1}
				);

			var job:StonedJob = new StonedJob(primeTask);
			job.go();
		}
	}
}