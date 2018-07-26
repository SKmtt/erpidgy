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

$(document).ready(function () {
    addEditables();
});

function addEditableForReply(element) {
    var label = $('#'+element).find('p.reply_plot:first');
    label.after('<input type ="text" style="display:none;" />');
    var textbox = label.next();
    var id = element.split('_')[1];
    textbox.val(label.html());

    label.click(function () {
        $(this).hide();
        $(this).next().show().focus();
    });

    textbox.focusout(function () {
        var message = {
            id: id,
            body: this.value
        };
        console.log('Updating message: ' + id);
        dispatcher.trigger('messages.update', message);

        $(this).hide();
        $(this).prev().show();
    });
}