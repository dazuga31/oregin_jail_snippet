
# Guía de Instalación en Español 🦉.

---

## Paso 1:

### Descargue el archivo con los archivos necesarios desde GitHub 
[Descargar📦](https://github.com/dazuga31/oregin_jail_snippet.git)

## Paso 2:

Mueva el contenido de la carpeta marko_snippet a la carpeta raíz del recurso oregin_police o siga los siguientes pasos:

### Coloque el archivo sr_marko_police.lua en la siguiente ruta:

origen_police\custom\server\sr_marko_police.lua

### Coloque el archivo cl_marko_police.lua en la siguiente ruta:

origen_police\custom\client\cl_marko_police.lua

### Coloque el archivo marko_federal.lua en la siguiente ruta:

origen_police\config\marko_federal.lua


## Interfaz web 🌐

### Navegue a la ruta origen_police\html\js\police.js.

1. Reemplace la línea No. 115 con:

```
<button class="btn-modal btn-nueva-condena w-100 p-0" onclick="policeFunctions.MarkoPreJailCheck($(this).closest('.info-box'))">${Translations.Add}</button>
```

Al final del archivo, después de la función AnkleTase, agregue una nueva función:

```
policeFunctions.MarkoPreJailCheck = function(parentElement) {
    const citizenID = parentElement.find('.input-id-condena').val();
    const mesesCondena = parentElement.find('.input-meses-condena').val();
    const peligro = parentElement.find('.input-p-condena').val();
    
    console.log('MarkoPreJailCheck llamado con:', { citizenID, mesesCondena, peligro });

    if (citizenID && mesesCondena && peligro) {
        console.log('Enviando solicitud al script del cliente con:', { citizenID, mesesCondena, peligro });
        $.post('http://origen_police/MarkoPreJailCheck', JSON.stringify({
            citizenID: citizenID,
            mesesCondena: mesesCondena,
            peligro: peligro
        }), function(result) {
            console.log('Resultado de la devolución de llamada recibido del script del cliente:', result.result, result.reason);
            if (result.result) {
                console.log('Pasando a addCondena con:', { citizenID, mesesCondena, peligro });
                policeFunctions.addCondena(citizenID, mesesCondena, peligro);
            } else {
                console.log('El script del cliente informó un error:', result.reason);
            }
        });
    } else {
        console.log('Datos inválidos proporcionados para MarkoPreJailCheck:', { citizenID, mesesCondena, peligro });
    }
};
```

### Navegue al archivo **origen_police\fxmanifest.lua**

Agregue algunas nuevas líneas en client_scripts (No olvide agregar una coma después de "radio/client/**/*.lua")

```
    -- Polyzone
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "custom/client/cl_marko_police.lua",
```

En server_scripts agregue:

```
"custom/server/sr_marko_police.lua",
```

### Navegue al archivo **origen_police\config\marko_federal.lua**

Configure su webhook para notificaciones detalladas de arrestos.

Configure ZoneSettings, establezca las zonas deseadas donde serán posibles los arrestos de jugadores.

Los jugadores que intenten arrestos fuera de estas zonas recibirán un mensaje de error adecuado.

### Localización en MFederal_lang.

Por defecto, he agregado 3 idiomas: Ucraniano, Español, Inglés.
Me disculpo de antemano por cualquier error gramatical (usé un traductor básico).

### Navegue al archivo origen_police\custom\server\sr_marko_police.lua

Opcionalmente agregue más banderas para nationalityEmojis.
- nationalityEmojis muestra la nacionalidad del jugador indicada durante la creación del personaje.

### Agregue sus propios enlaces en factionThumbnails para las facciones que utiliza en oregin_police.

🟨 Recomiendo usar imágenes directamente desde Discord o su propio CDN, evite URLs de Google Image o Imgur (solo una recomendación).

Si desea cambiar el formato de notificación, la función sendDiscordArrestNotification es responsable de esto.
🟥 Recomiendo hacerlo solo si sabe lo que está haciendo.

---

### Paso final.

🟩 Reinicie el servidor

### Comandos:

/drawjailinZones Mostrar zonas de arresto.

---

## Recomendaciones:

En CFG, coloque el recurso PolyZone antes de oregin_police.
Este snippet funciona como un "intermedio" entre la funcionalidad existente, por lo tanto, NO cambie el valor de Config.OwnPrisonSystem = false a true.
