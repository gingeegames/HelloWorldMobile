package
{
	import com.gingeegames.gamologee.guiModule.GingeeGuiModule;
	import com.gingeegames.gamologee.guiModule.gui.alignment.enum.GuiElementAlignmentMethods;
	import com.gingeegames.gamologee.guiModule.gui.text.GuiTextQuick;
	import com.gingeegames.gingeeAssetsIntegrator.GingeeAssetsIntegrator;
	import com.gingeegames.gingeeGamesInitiator.Gamologee;
	import com.gingeegames.gingeeTutorialModule.GingeeTutorialModule;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class GamologeeMobileHelloWorld extends Sprite
	{
		// EMBED FONTS
		[Embed(source="ARIAL.TTF", fontName="_arial", embedAsCFF="false")] 
		public static const _arial:Class;
		
		// EMBED USED ASSETS
		[Embed (source="assets/1.png")]
		private static const _bitmap:Class;
		public static var spriteBitmap:Bitmap = new _bitmap() as Bitmap;
		
		[Embed (source="assets/Background.jpg")]
		private static const _bitmapBG:Class;
		public static var bg:Bitmap = new _bitmapBG() as Bitmap;
		
		[Embed (source="assets/1.xml", mimeType="application/octet-stream")]
		public static const _xml:Class;
		public static const xml:Object = new _xml();
		
		public function GamologeeMobileHelloWorld()
		{
			super();
			// make sure stage is ready
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			// make sure stage is aligned/scaled correctly
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//>>>> GAMOLOGEE INITIALIZATION <<<<<<
			Gamologee.init(stage, "settings.xml", onCompleteSettings, Gamologee.CUSTOM, '',GingeeGuiModule, GingeeAssetsIntegrator, GingeeTutorialModule);
		}
		
		
		private function onCompleteSettings():void
		{
			// set background
			GingeeGuiModule.setBackgroundImage(bg);
			
			// Create first sprite-atlas
			GingeeGuiModule.createSpriteAtlas("default", spriteBitmap, XML(xml));
			
			// setup a dynamic text field
			const helloWorld:GuiTextQuick = new GuiTextQuick("hello world!", 60, 0xff0000, '', uint.MAX_VALUE, 1, "helloWorldText");
			helloWorld.align = GuiElementAlignmentMethods.STAGE_MIDDLE_CENTER;
			addChild(helloWorld);
			
			//activate a simple hello-tutorial
			helloTutorial();
			
			// REST OF THE CODE GOES HERE
		}
		
		private function helloTutorial():void
		{
			GingeeTutorialModule.startTutorial("tutorial.xml", onCompleteTutorials);
		}
		
		private function onCompleteTutorials():void
		{
			trace("turtorials complete!");
		}
	}
}
