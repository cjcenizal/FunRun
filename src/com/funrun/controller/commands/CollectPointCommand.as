package com.funrun.controller.commands
{
	import com.funrun.controller.signals.DrawPointsRequest;
	import com.funrun.controller.signals.PlaySoundRequest;
	import com.funrun.controller.signals.vo.CollectPointVo;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.constants.Sounds;
	
	import org.robotlegs.mvcs.Command;
	
	public class CollectPointCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var vo:CollectPointVo;
		
		// Models.
		
		[Inject]
		public var pointsModel:PointsModel;
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var playSoundRequest:PlaySoundRequest;
		
		[Inject]
		public var drawPointsRequest:DrawPointsRequest;
		
		override public function execute():void {
			if ( pointsModel.hasPointFor( vo.segmentId, vo.blockId ) ) {
				if ( pointsModel.collectFor( vo.segmentId, vo.blockId, 1 ) ) {
					playSoundRequest.dispatch( Sounds.POINT );
					playerModel.points += 1;
					drawPointsRequest.dispatch( pointsModel.collectedAmount );
				}
			}
		}
	}
}