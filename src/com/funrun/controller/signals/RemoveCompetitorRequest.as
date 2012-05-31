package com.funrun.controller.signals {

	import com.funrun.model.vo.CompetitorVO;

	import org.osflash.signals.Signal;

	public class RemoveCompetitorRequest extends Signal {
		
		public function RemoveCompetitorRequest() {
			super( CompetitorVO );
		}
	}
}
