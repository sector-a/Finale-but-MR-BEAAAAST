import flixel.FlxG;
import flixel.input.FlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionInputDigital;
import flixel.input.actions.FlxActionManager;
import flixel.input.actions.FlxActionSet;
import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class KeyBinds
{

    public static function resetBinds():Void{

        FlxG.save.data.upBind = "W";
        FlxG.save.data.downBind = "S";
        FlxG.save.data.leftBind = "A";
        FlxG.save.data.rightBind = "D";
        FlxG.save.data.killBind = "R";
        PlayerSettings.player1.controls.loadKeyBinds();

	}

    public static function keyCheck():Void
    {
        if(FlxG.save.data.upBind != "F"){
            FlxG.save.data.upBind = "F";
            trace("No UP");
        }
        if(FlxG.save.data.downBind != "J"){
            FlxG.save.data.downBind = "J";
            trace("No DOWN");
        }
        if(FlxG.save.data.leftBind != "D"){
            FlxG.save.data.leftBind = "D";
            trace("No LEFT");
        }
        if(FlxG.save.data.rightBind != "K"){
            FlxG.save.data.rightBind = "K";
            trace("No RIGHT");
        }
        if(FlxG.save.data.killBind == null){
            FlxG.save.data.killBind = "R";
            trace("No KILL");
        }
    }

}