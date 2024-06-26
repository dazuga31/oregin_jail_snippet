
# Installation Guide in English 🦉.

---

## Step 1:

### Download the archive with the necessary files from GitHub 
[Download📦](https://github.com/dazuga31/oregin_jail_snippet.git)

## Step 2:

Move the contents of the marko_snippet folder to the root folder of the oregin_police resource or follow the steps below:

### Place the sr_marko_police.lua file in the following path:

origen_police\custom\server\sr_marko_police.lua

### Place the cl_marko_police.lua file in the following path:

origen_police\custom\client\cl_marko_police.lua

### Place the marko_federal.lua file in the following path:

origen_police\config\marko_federal.lua


## Web Interface 🌐

### Navigate to the origen_police\html\js\police.js path.

1. Replace line No. 115 with:

```
<button class="btn-modal btn-nueva-condena w-100 p-0" onclick="policeFunctions.MarkoPreJailCheck($(this).closest('.info-box'))">${Translations.Add}</button>
```

At the end of the file, after the AnkleTase function, add a new function:

```
policeFunctions.MarkoPreJailCheck = function(parentElement) {
    const citizenID = parentElement.find('.input-id-condena').val();
    const mesesCondena = parentElement.find('.input-meses-condena').val();
    const peligro = parentElement.find('.input-p-condena').val();
    
    console.log('MarkoPreJailCheck called with:', { citizenID, mesesCondena, peligro });

    if (citizenID && mesesCondena && peligro) {
        console.log('Sending request to client script with:', { citizenID, mesesCondena, peligro });
        $.post('http://origen_police/MarkoPreJailCheck', JSON.stringify({
            citizenID: citizenID,
            mesesCondena: mesesCondena,
            peligro: peligro
        }), function(result) {
            console.log('Received callback result from client script:', result.result, result.reason);
            if (result.result) {
                console.log('Passing to addCondena with:', { citizenID, mesesCondena, peligro });
                policeFunctions.addCondena(citizenID, mesesCondena, peligro);
            } else {
                console.log('Client script reported an error:', result.reason);
            }
        });
    } else {
        console.log('Invalid data provided for MarkoPreJailCheck:', { citizenID, mesesCondena, peligro });
    }
};
```

### Navigate to the file **origen_police\fxmanifest.lua**

Add a few new lines in client_scripts (Don't forget to add a comma after "radio/client/**/*.lua")

```
    -- Polyzone
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "custom/client/cl_marko_police.lua",
```

In server_scripts add:

```
"custom/server/sr_marko_police.lua",
```

### Navigate to the file **origen_police\config\marko_federal.lua**

Set up your webhook for detailed arrest notifications.

Configure ZoneSettings, set the desired zones where player arrests are possible.

Players attempting arrests outside these zones will receive an appropriate error message.

### Localization in MFederal_lang.

By default, I've added 3 languages: Ukrainian, Spanish, English.
I apologize in advance for any grammatical errors (I used a basic translator).

### Navigate to the file origen_police\custom\server\sr_marko_police.lua

Optionally add more flags for nationalityEmojis.
- nationalityEmojis display the player's nationality as indicated during character creation.

### Add your own links in factionThumbnails for the factions you use in oregin_police.

🟨 I recommend using images directly from Discord or your own CDN, avoid URLs from Google Image or Imgur (just a recommendation).

If you want to change the notification format, the function sendDiscordArrestNotification is responsible for this.
🟥 I recommend doing this only if you know what you are doing.

---

### Final Step.

🟩 Restart the server

### Commands:

/drawjailinZones Display arrest zones.

---

## Recommendations:

In CFG, place the PolyZone resource before oregin_police.
This snippet works as an "intermediate" between the existing functionality, so DO NOT switch the value of Config.OwnPrisonSystem = false to true.
