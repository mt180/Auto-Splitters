state("Hamilton")
{
    int  SceneIndex : "UnityPlayer.dll", 0x1680300,  0x28, 0x0,  0x98;
    bool GameEnd    : "UnityPlayer.dll", 0x016832D8, 0x8,  0x58, 0x388, 0x118, 0x40;
}

startup
{
    vars.TimerModel = new TimerModel { CurrentState = timer };
    settings.Add("enterBuilding", true, "Split on enter building?");
}

update
{
    if (old.SceneIndex == 2 && current.SceneIndex == 0 && settings.ResetEnabled)
    {
        vars.TimerModel.Reset();
    }
}

start
{
    return old.SceneIndex == 0 && current.SceneIndex == 1;
}

split
{
    //enter building
    if (settings["enterBuilding"] && old.SceneIndex == 1 && current.SceneIndex == 2)
        return true;
    
    //win
    if (!old.GameEnd && current.GameEnd)
        return true;
}

reset
{
    return false;
}
