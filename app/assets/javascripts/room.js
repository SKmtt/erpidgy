function createAvailableUsers(users, type) {
    // type = '#players_input'
    $(type).autocomplete({
        source: users,
        select: function (event, ui) {
            event.preventDefault();
            $('input' + type).val('');
            addUser(ui.item.value, type);
        }
    });
}