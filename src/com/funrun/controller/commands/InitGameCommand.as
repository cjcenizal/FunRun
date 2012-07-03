package com.funrun.controller.commands
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.textures.BitmapTexture;
	
	import com.funrun.controller.signals.AddLightRequest;
	import com.funrun.controller.signals.AddMaterialRequest;
	import com.funrun.controller.signals.AddObjectToSceneRequest;
	import com.funrun.controller.signals.AddPlayerRequest;
	import com.funrun.controller.signals.AddView3DRequest;
	import com.funrun.controller.signals.LoadBlocksRequest;
	import com.funrun.controller.signals.LoadSegmentsRequest;
	import com.funrun.controller.signals.ShowStatsRequest;
	import com.funrun.model.InterpolationModel;
	import com.funrun.model.KeyboardModel;
	import com.funrun.model.LightsModel;
	import com.funrun.model.MaterialsModel;
	import com.funrun.model.PointsModel;
	import com.funrun.model.TimeModel;
	import com.funrun.model.View3DModel;
	import com.funrun.model.constants.TimeConstants;
	import com.funrun.model.constants.TrackConstants;
	import com.funrun.model.state.ProductionState;
	
	import flash.display.Bitmap;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.macrobot.SequenceCommand;
	
	/**
	 * BuildGameCommand assigns materials and lights to the track.
	 */
	public class InitGameCommand extends SequenceCommand {
		
		public function InitGameCommand() {
			addCommand( LoadBlocksCommand );
			addCommand( SetupGameCommand );
		}
		
	}
}