package com.funrun.controller.commands
{
	import com.funrun.controller.signals.PlaySoundRequest;
	import com.funrun.model.PointsModel;
	import com.funrun.model.constants.Sounds;
	import com.funrun.model.vo.CollectPointVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class CollectPointCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:CollectPointVo;
		
		// Models.
		
		[Inject]
		public var pointsModel:PointsModel;
		
		// Commands.
		
		[Inject]
		public var playSoundRequest:PlaySoundRequest;
		
		override public function execute():void {
			if ( pointsModel.hasPointFor( vo.segmentId, vo.blockId ) ) {
				if ( pointsModel.collectFor( vo.segmentId, vo.blockId, 1 ) ) {
					playSoundRequest.dispatch( Sounds.POINT );
				}
			}
		}
	}
}