package com.funrun.controller.commands {
	
	import com.cenizal.ui.AbstractLabel;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.NametagsModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.vo.CompetitorVO;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateCompetitorsCommand extends Command {
		
		// Models.
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		[Inject]
		public var interpolationModel:InterpolationModel;
		
		[Inject]
		public var nametagsModel:NametagsModel;
		
		[Inject]
		public var view3DModel:View3DModel;
		
		override public function execute():void {
			var len:int = competitorsModel.numCompetitors;
			var competitor:CompetitorVO;
			var nametag:AbstractLabel;
			for ( var i:int = 0; i < len; i++ ) {
				competitor = competitorsModel.getAt( i );
				competitor.interpolate( interpolationModel.percent );
				nametag = nametagsModel.getWithId( competitor.id.toString() );
				if ( nametag ) {
					var pos:Point = view3DModel.get2DFrom3D( competitor.mesh.position );
					nametag.x = pos.x;
					nametag.y = pos.y;
				}
			}
			interpolationModel.increment();
		}
	}
}
