# Інструкція Українською Мовою 🦉.

---

## Крок 1:

### Скачати аргхів з необхдними файлами з GitHub 
[Завантажити📦](https://github.com/dazuga31/oregin_jail_snippet.git)

## Крок 2:

Перемістіть вміс теки marko_snippet в кореневу теку ресурсу oregin_police або скористайтесь наступними кроками:

### Розмістіть файл sr_marko_police.lua за шляхом:

origen_police\custom\server\sr_marko_police.lua

### Розмістіть файл cl_marko_police.lua за шляхом:

origen_police\custom\client\сl_marko_police.lua

### Розмістіть файл marko_federal.lua за шляхом:

origen_police\config\marko_federal.lua


## Веб інтерфейс 🌐

### Перейдіть за шляхом origen_police\html\js\police.js.

1. Замініть рядок № 115 на:

```
<button class="btn-modal btn-nueva-condena w-100 p-0" onclick="policeFunctions.MarkoPreJailCheck($(this).closest('.info-box'))">${Translations.Add}</button>
```

В кінці файлу після функції AnkleTase розмістіть нову функцію:

--- тут буде код функції (він надто довгий)
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
                policeFunctions.addCondena(parentElement);
            } else {
                console.log('Pre-check failed, notifying user');
                if (result.reason === "Час арешту не може перевищувати 60 днів") {
                    sendNotification('error', 'Час арешту не може перевищувати 60 днів');
                } else if (result.reason === "Громадянин занадто далеко від вас!") {
                    sendNotification('error', 'Громадянин занадто далеко від вас!');
                } else if (result.reason === "Ви занадто далеко до місця ув'язнення!") {
                    sendNotification('error', 'Ви занадто далеко до місця ув\'язнення!');
                } else if (result.reason === "Ув'язнений занадто далеко до місця ув'язнення!") {
                    sendNotification('error', 'Ув\'язнений занадто далеко до місця ув\'язнення!');
                } else if (result.reason === "Ви не можете арештувати самого себе!") {
                    sendNotification('error', 'Ви не можете арештувати самого себе!');
                } else {
                    sendNotification('error', result.reason || 'Попередня перевірка не вдалася');
                }
            }
        });
    } else {
        console.log('All fields are required');
        sendNotification('error', 'Усі поля мають бути заповнені');
    }
};


```

## Крок 3 Встановіть залежності.

PolyZone: [Завантажити📦](https://github.com/mkafrin/PolyZone)


## Крок 4: Налаштування:

### Перейдіть до файлу **origen_police\fxmanifest.lua**

Додайте декілька нових рядків в client_scripts (Не забудтьте додати кому , після "radio/client/**/*.lua")

    -- Polyzone
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "custom/client/сl_marko_police.lua",
В server_scripts додайте:

"custom/server/sr_marko_police.lua",




### Перейдіть до файлу **origen_police\config\marko_federal.lua**

Встановіть власний вебхук для отримання детальних повідомлень аршету.

Налшатуйте ZoneSettings, встановіть бажані зони в яких буде можливий арешт гравців.

Тобто поза цими зонами при спробі арешту гравець буде отримувати повідомлення з відповідною помилкою.

### Виконайте локалізацію в MFederal_lang.

За замовчуванням я додав 3 мови: Українська, Іспаньска, Англійска.
Одразу вибачаюсь якщо допустив граматичні помилки (всетаки я користувався звичайнісіньким перекладачем).


### Перейдіть до файлу origen_police\custom\server\sr_marko_police.lua

За бажанням додайте більше прапорців для nationalityEmojis.
- nationalityEmojis відображає національність гравця вказану при створенні песонажа.

### Додайте власні посилання в factionThumbnails для фракцій які ви використовуєте в oregin_police.

🟨 Рекомендую використовувати зображення на пряму з Discord або власного CDN, уникайте url з Google Image або Imgur (лише рекомендація)

Якщо ви бажаєте змінити формат повідомлення то функція sendDiscordArrestNotification відповідає за це.
🟥 Рекомендую робити це лише якщо ви знаєте що ви робите.

---
















### Останній крок.

🟩 Перезавантажте сервер




### Команди:

/drawjailinZones Відображення зон для арешту.


---









## Рекомендації:

в CFG розмістіть ресурс PolyZone перед oregin_police.
Цей snippet працює як "Проміжок" між вже існуючим функціоналом тому НЕ перемикайте значення Config.OwnPrisionSystem = false на true.
