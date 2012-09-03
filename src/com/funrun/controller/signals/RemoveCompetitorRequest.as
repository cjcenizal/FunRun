package com.funrun.controller.signals {

	import com.funrun.model.vo.CompetitorVo;

	import org.osflash.signals.Signal;

	public class RemoveCompetitorRequest extends Signal {
		
		public function RemoveCompetitorRequest() {
			super( CompetitorVo );
		}
	}
}
