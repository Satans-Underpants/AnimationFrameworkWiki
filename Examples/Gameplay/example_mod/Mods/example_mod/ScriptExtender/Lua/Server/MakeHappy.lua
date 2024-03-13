
----------------------------------------------------------------------------------------
-- This example add-on mod has been written for the AnimationFramework by Lune
-- The AnimationFramework is currently WIP, if AF changes in a significant way
-- Add-ons might have to be reworked 
----------------------------------------------------------------------------------------

-- save the GUIDs of the entities
local sex_proxies; 
local sex_originals; 


-- Listen to a AnimationFramework specific event to occur (here - Sex started)
-- this gives access to the "proxys - see wiki for more information")
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(target, status, caster, _)

    if status == "SEX_ACTOR" then

        -- create a new table where the sex proxies are stored
        if not sex_proxies then
            sex_proxies = {}
        end

        -- store each (2) entity in the list
        table.insert(sex_proxies, target)
        table.insert(sex_proxies, caster)

    end

end)


-- Listen to a AnimationFramework specific event to occur (here - Spells)
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", function(caster, target, spell, _, _, _)

    if spell == "AskForSex" then
    
        -- create a new table where the original characters are stored
        if not sex_originals then
            sex_originals = {}
        end

         -- store each (2) entity in the list
        table.insert(sex_originals, target)
        table.insert(sex_originals, caster)
    end


    -- Listen to a AnimationFramework specific event to occur (here - Sex ended)
    if spell == "zzzEndSex" then
        -- call a custom function
         makeHappy()
    end
end)


--Add the "Happy" Buff
function makeHappy()

    for _, entity in pairs(sex_originals) do
        Osi.ApplyStatus(entity, "ASTARION_HAPPY", 50)
    end

    sex_originals = nil
end

