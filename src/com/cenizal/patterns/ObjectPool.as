package com.cenizal.patterns
{

	/**
	 * @author CJ Cenizal.
	 *
	 * ObjectPool lets you store unused objects
	 * without releasing their memory. This
	 * eliminates allocation time the next time
	 * you need an object, because you can
	 * just get it from the pool.
	 */
	public class ObjectPool
	{
		private var _objs:Array = [];
		private var _len:int = 0;

		public function ObjectPool() {
		}

		/**
		 * Add an object to the pool.
		 * 
		 * @param * An object to store.
		 */
		public function add( obj:* ):void {
			_objs.push( obj );
		}

		/**
		 * Request an object from the pool.
		 * 
		 * @returns * An object for use.
		 */
		public function checkOut():* {
			return _objs[ --_len ];
		}

		/**
		 * Return an object to the pool.
		 * 
		 * @param * An object no longer in use.
		 */
		public function checkIn( obj:* ) {
			_objs[ _len++ ] = obj;
		}

		/**
		 * Check to see if the pool has
		 * objects available.
		 * 
		 * @returns Boolean Whether it has available objects.
		 */
		public function get isEmpty():Boolean {
			return _len == 0;
		}
	}
}
