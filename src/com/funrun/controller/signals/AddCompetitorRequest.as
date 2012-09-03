package com.funrun.controller.signals {

	import com.funrun.model.vo.CompetitorVo;

	import org.osflash.signals.Signal;

	public class AddCompetitorRequest extends Signal {
		
		public function AddCompetitorRequest() {
			super( CompetitorVo );
		}
	}
}
