local Translations = {
    notify = {
        no_torch = "Je hebt geen lasbrander!",
        unlocking_cancelled = "Ontgrendelen geannuleerd!",
        unlocking_success = "Voertuig succesvol ontgrendeld!"
    },
    ox_target = {
        unlock_vehicle = "Openbreken met Lasbrander"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
