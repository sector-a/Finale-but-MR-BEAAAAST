package;

import flixel.util.FlxTimer;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import Shaders;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class Beastmenu extends MusicBeatState
{
    var dis:DistortionEffect;
    var shaders:Array<ShaderEffect> = [];
    var canClick:Bool = true;
    var menub:FlxSprite;
    var menuset:FlxSprite;
    var menus:FlxSprite;
    var menusd:FlxSprite;
    var m:FlxSprite;

    override function create()
    {
        Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

        super.create();

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting", null);
		#end

        setup();
    }

    function setup()//idk for what
    {
        dis = new DistortionEffect(0, 0.25, false);
        dis.shader.working.value = [true];
        addShader(dis);

        FlxG.camera.fade(FlxColor.BLACK, 1, true);

        FlxG.sound.playMusic(Paths.music('Menu'), 1, true);

       //m = new FlxSprite().loadGraphic(Paths.image('arrow'));
        //m.antialiasing = true;

        //FlxG.mouse.visible = true;
        //FlxG.mouse.load(Paths.image('arrow'), 0.5);

        var menup:FlxSprite = new FlxSprite().loadGraphic(Paths.image('background'));
        menup.antialiasing = true;
        menup.screenCenter();
        add(menup);

        menub = new FlxSprite(25, 50).loadGraphic(Paths.image('masturbeast'));
        menub.antialiasing = true;
        //menub.screenCenter();
        add(menub);

        menus = new FlxSprite(650, 0).loadGraphic(Paths.image('seongihun'));
        menus.antialiasing = true;
        //menus.screenCenter();
        add(menus);

        menusd = new FlxSprite(800, 425).loadGraphic(Paths.image('sound_effect'));
        menusd.antialiasing = true;
        //menusd.screenCenter();
        add(menusd);

        menuset = new FlxSprite(125, 400).loadGraphic(Paths.image('options'));
        menuset.antialiasing = true;
        //menuset.screenCenter();
        add(menuset);
    }

    function addShader(effect:ShaderEffect)
    {
        shaders.push(effect);
    
        var newCamEffects:Array<BitmapFilter> = [];
    
        for (i in shaders)
        {
           newCamEffects.push(new ShaderFilter(i.shader));
        }
    
        FlxG.camera.setFilters(newCamEffects);
    }

    function select(name:String)
    {
        #if windows
        FlxG.mouse.visible = true;
        #else
        FlxG.mouse.visible = false;
        #end

        if (FlxG.mouse.pressed && canClick)
        {
            FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
            canClick = false;
            FlxG.camera.flash(FlxColor.WHITE);
            new FlxTimer().start(1, function(tmr:FlxTimer)
                FlxG.camera.fade(FlxColor.BLACK, 1, false));
            switch(name)
            {
            case 'menuset':
                new FlxTimer().start(2, function(tmr:FlxTimer)
                    FlxG.switchState(new OptionsMenu()));
                    trace('settings');
            case 'menub':
                PlayState.SONG = Song.loadFromJson('finalrapbeast', 'finalrapbeast');
				PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 1;
                PlayState.storyWeek = 0;
                new FlxTimer().start(2, function(tmr:FlxTimer)
				    LoadingState.loadAndSwitchState(new PlayState()));
            case 'menus':
                PlayState.SONG = Song.loadFromJson('finalrapsquid', 'finalrapbeast');
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 1;
                PlayState.storyWeek = 0;
                new FlxTimer().start(2, function(tmr:FlxTimer)
                    LoadingState.loadAndSwitchState(new PlayState()));
            default:

            }
         }
    }

    override function update(elapsed:Float)
    {

        if (FlxG.mouse.overlaps(menuset))
		{
           select('menuset');
		}
        if (FlxG.mouse.overlaps(menusd))
        {
           if (FlxG.mouse.pressed && canClick)
            {
              FlxG.sound.play(Paths.sound('mrbeast'), 2);
              trace('sound');
            }
        }
        if (FlxG.mouse.overlaps(menub))
        {
            select('menub');
        }
        if (FlxG.mouse.overlaps(menus))
        {
            select('menus');
        }

        dis.update(elapsed);
        super.update(elapsed);
    }
}
