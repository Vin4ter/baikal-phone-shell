function application_list_refresh(item) {
    var page = 0
    appPages = []
    appPages[page] = []
    item.model = 0
    for (var i in apps) {
        var app = apps[i]
        appPages[page].push(app)
    }
    item.model = appPages[0].length
}

function set_bat_level_width(item, percentage, output) {
    var extra_percentage = 100 - percentage
    var extra_height = item.height * extra_percentage / 100
    var remaining_height = item.height - extra_height
    output.height = remaining_height
}

function handle_battery_monitor(item, output) {
    set_bat_level_width(item, battery_handler.battery_level(), output)
    switch(battery_handler.battery_charge_status()) {
        case 'Charging':
            output.color = "#19d178"
            break
        case 'Full':
            output.color = "#19d178"
            break
        case 'Discharging':
            output.color = "#ffffff"
            break
        case 'Unknown':
            output.color = "#19d178"
            break
    }
}
