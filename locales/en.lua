local Translations = {
    notify = {
        no_torch = "You need an welding torch and gasbottle",
        unlocking_cancelled = "Unlocking cancelled",
        unlocking_success = "Vehicle is succesfully unlocked"
    },
    ox_target = {
        unlock_vehicle = "Break open with welding torch"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
