package com.funrun.controller.commands
{
	import com.funrun.model.CharactersModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CharacterVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectCharacterCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var id:String;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var charactersModel:CharactersModel;
		
		override public function execute():void
		{
			var vo:CharacterVo = charactersModel.getWithId( id );
			vo.mesh.castsShadows = true;
			playerModel.setCharacter( vo );
		}
	}
}