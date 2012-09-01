/**
Title:			Perlin noise
Version:		1.1
Author:			Ron Valstar
Author URI:		http://www.sjeiti.com/
Original code port from http://mrl.nyu.edu/~perlin/noise/
and some help from http://freespace.virgin.net/hugo.elias/models/m_perlin.htm
Park Miller random number implemetation used from Michael Baczynski (www.polygonal.de)
*/
package nl.ronvalstar.math {
	import de.polygonal.math.PM_PRNG;
	public class Perlin {
		private static var bInit:Boolean = false;
		//
		private static var p:Array = [151,160,137,91,90,15,131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,134,139,48,27,166,77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,18,169,200,196,135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,226,250,124,123,5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,167,43,172,9,129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,246,97,228,251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,14,239,107,49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,150,254,138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,151,160,137,91,90,15,131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,134,139,48,27,166,77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,18,169,200,196,135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,226,250,124,123,5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,167,43,172,9,129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,246,97,228,251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,14,239,107,49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,150,254,138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180];
		private static var iOctaves:int = 4;
		private static var fPersistence:Number = .5;
		//
		private static var iSeed:int = 123;
		private static var oRand:PM_PRNG;
		//
		private static var iXoffset:Number;
		private static var iYoffset:Number;
		private static var iZoffset:Number;
		//
		// PUBLIC
		public static function noise(x:Number, y:Number=1, z:Number=1):Number {
			if (!bInit) init();
			var s:Number = 0;
			var a:Number = 0;
			for (var i:uint;i<iOctaves;i++) {
				var fFreq:Number = Math.pow(2,i);
				var fPers:Number = Math.pow(fPersistence,i);
				s += n((x+iXoffset)*fFreq,(y+iYoffset)*fFreq,(z+iZoffset)*fFreq) * fPers;
				a += fPers;
			}
			return (s/a+1)*.5;
		}
		// GETTER / SETTER
		//
		// get octaves
		public static function get octaves():int {
			return iOctaves;
		}
		// set octaves
		public static function set octaves(_iOctaves:int):void {
			iOctaves = _iOctaves;
		}
		//
		// get falloff
		public static function get falloff():Number {
			return fPersistence;
		}
		// set falloff
		public static function set falloff(_fPersistence:Number):void {
			fPersistence = _fPersistence;
		}
		//
		// get seed
		public static function get seed():Number {
			if (!bInit) init();
			return iSeed;
		}
		// set seed
		public static function set seed(_iSeed:Number):void {
			if (!bInit) init();
			iSeed = _iSeed;
			oRand.seed = iSeed;
			seedOffset();
		}
		//
		// PRIVATE
		private static function seedOffset():void {
			iXoffset = oRand.nextInt();
			iYoffset = oRand.nextInt();
			iZoffset = oRand.nextInt();
		}
		private static function init():void {
			oRand = new PM_PRNG();
			oRand.seed = iSeed;
			seedOffset();
			bInit = true;
		}
		private static function n(x:Number, y:Number, z:Number):Number {
			var X:int = int(Math.floor(x))&255;
			var Y:int = int(Math.floor(y))&255;
			var Z:int = int(Math.floor(z))&255;
			x -= Math.floor(x);
			y -= Math.floor(y);
			z -= Math.floor(z);
			var u:Number = fade(x);
			var v:Number = fade(y);
			var w:Number = fade(z);
			var A:int = p[X  ]+Y, AA = p[A]+Z, AB = p[A+1]+Z;
			var B:int = p[X+1]+Y, BA = p[B]+Z, BB = p[B+1]+Z;
			return lerp(w,	lerp(v,	lerp(u,	grad(p[AA  ], x  , y  , z   ),
											grad(p[BA  ], x-1, y  , z   )),
									lerp(u, grad(p[AB  ], x  , y-1, z   ),
											grad(p[BB  ], x-1, y-1, z   ))),
							lerp(v, lerp(u, grad(p[AA+1], x  , y  , z-1 ),
											grad(p[BA+1], x-1, y  , z-1 )),
									lerp(u, grad(p[AB+1], x  , y-1, z-1 ),
											grad(p[BB+1], x-1, y-1, z-1 ))));
		}
		private static function fade(t:Number):Number {
			return t * t * t * (t * (t * 6 - 15) + 10);
		}
		private static function lerp(t:Number,a:Number,b:Number):Number {
			return a + t * (b - a);
		}
		private static function grad(hash:int, x:Number, y:Number, z:Number):Number {
			var h:int = hash & 15;
			var u:Number = h<8 ? x : y;
			var v:Number = h<4 ? y : h==12||h==14 ? x : z;
			return ((h&1) == 0 ? u : -u) + ((h&2) == 0 ? v : -v);
		}
	}
}