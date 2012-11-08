package com.funrun.controller.commands
{
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.RemoveObjectFromSceneRequest;
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
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void
		{
			if ( playerModel.character ) {
				removeObjectFromSceneRequest.dispatch( playerModel.character.mesh );
			}
			var vo:CharacterVo = charactersModel.getWithId( id );
			vo.mesh.castsShadows = true;
			playerModel.character = vo;
			addObjectToSceneRequest.dispatch( playerModel.character.mesh );
		}
	}
}