package
{
	import com.gingeegames.gamologee.guiModule.GingeeGuiModule;
	import com.gingeegames.gamologee.guiModule.gui.alignment.enum.GuiElementAlignmentMethods;
	import com.gingeegames.gamologee.guiModule.gui.text.GuiTextQuick;
	import com.gingeegames.gingeeAssetsIntegrator.GingeeAssetsIntegrator;
	import com.gingeegames.gingeeGamesInitiator.Gingee;
	import com.gingeegames.gingeeTutorialModule.GingeeTutorialModule;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class GingeeMobileHelloWorld extends Sprite
	{
		// EMBED FONTS
		[Embed(source="ARIAL.TTF", fontName="_arial", embedAsCFF="false")] 
		public static const _arial:Class;
		
		// EMBED USED ASSETS
		[Embed (source="/assets/1.png")]
		private static const _bitmap:Class;
		public static var spriteBitmap:Bitmap = new _bitmap() as Bitmap;
		
		[Embed (source="/assets/Background.jpg")]
		private static const _bitmapBG:Class;
		public static var bg:Bitmap = new _bitmapBG() as Bitmap;
		
		[Embed (source="/assets/1.xml", mimeType="application/octet-stream")]
		public static const _xml:Class;
		public static const xml:Object = new _xml();
		
		
		public static var helloWorldTxt:GuiTextQuick;
		public function GingeeMobileHelloWorld()
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
			
			//>>>> Gingee INITIALIZATION <<<<<<
			Gingee.init(stage, "settings.xml", onCompleteSettings, Gingee.CUSTOM, '',GingeeGuiModule, GingeeAssetsIntegrator, GingeeTutorialModule);
		}
		
		
		private function onCompleteSettings():void
		{
			// set background
			GingeeGuiModule.setBackgroundImage(bg);
			
			// Create first sprite-atlas
			GingeeGuiModule.createSpriteAtlas("tutorialSpriteAtlas", spriteBitmap, XML(xml));
			
			// setup a dynamic text field
			helloWorldTxt = new GuiTextQuick("hello world!", 60, 0xff0000, '', uint.MAX_VALUE, 1, "helloWorldText");
			helloWorldTxt.align = GuiElementAlignmentMethods.STAGE_MIDDLE_CENTER;
			addChild(helloWorldTxt);
			
			//activate a simple hello-tutorial
			helloTutorial();
			
			// REST OF THE CODE GOES HERE
		}
		
		// ............................. TUTORIAL HANDLING .....................................
		
		private function helloTutorial():void
		{
			// SUBMIT TUTORIAL FUNCTIONS FOR DYNAMIC TUTORIAL DATA INJECTION
			GingeeTutorialModule.submitFunctionDefinition("quitTutorial", quitTutorial);
			GingeeTutorialModule.submitFunctionDefinition("pause", pauseTutorial);
			GingeeTutorialModule.submitFunctionDefinition("continueTutorial", continueTutorial);
			
			
			GingeeTutorialModule.startTutorial("tutorial.xml", onCompleteTutorials);
		}
		
		private function quitTutorial():void
		{
			// Quit tutorial cleanup here
		}
		
		private function pauseTutorial():void
		{
			// Pause tutorial cleanup here
		}
		
		private function continueTutorial():void
		{
			// Continue tutorial cleanup here
		}
		
		private function onCompleteTutorials():void
		{
			GingeeTutorialModule.quitTutorials();
			helloWorldTxt.text = "Tutorial complete!";
			GingeeMobileHelloWorld.helloWorldTxt.align = GuiElementAlignmentMethods.STAGE_MIDDLE_CENTER;
		}
	}
}
