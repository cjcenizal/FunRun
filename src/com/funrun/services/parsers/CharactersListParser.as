package com.funrun.services.parsers
{
	public class CharactersListParser extends AbstractParser
	{
		
		private const LIST:String = "list";
		
		public function CharactersListParser( data:Object ) {
			super( data );
		}
		
		public function getAt( index:int ):CharacterParser {
			return new CharacterParser( data[ LIST ][ index ] );
		}
		
		public function get length():int {
			return ( data[ LIST ] as Array ).length;
		}
	}
}